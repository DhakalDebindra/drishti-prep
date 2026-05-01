"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { AlertCircle, Search } from "lucide-react";
import { createEnrollment } from "../actions";
import { searchUsers, type UserHit } from "./searchUsers";

type Module = {
  id: string;
  name: string;
  slug: string;
  price_paisa: number | null;
  currency: string;
};

export default function NewEnrollmentClient({
  modules,
}: {
  modules: Module[];
}) {
  const [query, setQuery] = useState("");
  const [results, setResults] = useState<UserHit[]>([]);
  const [isSearching, setIsSearching] = useState(false);
  const [selectedUser, setSelectedUser] = useState<UserHit | null>(null);

  const [moduleId, setModuleId] = useState<string>("");
  const [amountRupees, setAmountRupees] = useState<string>("");
  const [paymentReference, setPaymentReference] = useState("");
  const [adminNotes, setAdminNotes] = useState("");

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const debouncedQuery = useDebounced(query, 250);

  useEffect(() => {
    let cancelled = false;
    if (selectedUser) return; // don't keep searching once a user is picked
    if (debouncedQuery.trim().length < 2) {
      setResults([]);
      return;
    }

    const performSearch = async () => {
      setIsSearching(true);
      try {
        const hits = await searchUsers(debouncedQuery.trim());
        if (!cancelled) setResults(hits);
      } catch (e) {
        console.error(e);
        if (!cancelled) setResults([]);
      } finally {
        if (!cancelled) setIsSearching(false);
      }
    };

    performSearch();
    return () => {
      cancelled = true;
    };
  }, [debouncedQuery, selectedUser]);

  const selectedModule = useMemo(
    () => modules.find((m) => m.id === moduleId) ?? null,
    [moduleId, modules]
  );

  // Pre-fill amount when a module is picked.
  useEffect(() => {
    if (selectedModule?.price_paisa != null) {
      setAmountRupees(String(selectedModule.price_paisa / 100));
    }
  }, [selectedModule]);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError(null);

    if (!selectedUser) {
      setError("Pick a user first.");
      return;
    }
    if (!moduleId) {
      setError("Pick a module.");
      return;
    }
    const amount = Number(amountRupees);
    if (!Number.isFinite(amount) || amount < 0) {
      setError("Amount must be a non-negative number.");
      return;
    }

    setIsSubmitting(true);
    try {
      await createEnrollment({
        user_id: selectedUser.id,
        module_id: moduleId,
        amount_paid_paisa: Math.round(amount * 100),
        payment_reference: paymentReference || null,
        admin_notes: adminNotes || null,
      });
      // createEnrollment redirects on success
    } catch (e: any) {
      setError(e?.message || "Could not create enrollment.");
      setIsSubmitting(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="bg-white rounded-lg shadow p-6 space-y-6">
      {error && (
        <div role="alert" className="bg-red-50 text-red-900 p-3 rounded-md text-sm flex items-center gap-2">
          <AlertCircle className="w-4 h-4 flex-shrink-0" />
          {error}
        </div>
      )}

      {/* User picker */}
      <div className="space-y-2">
        <Label htmlFor="user-search">User (search by email or name)</Label>
        {selectedUser ? (
          <div className="flex items-center justify-between gap-3 border rounded-md p-3 bg-blue-50">
            <div className="text-sm">
              <div className="font-medium">{selectedUser.full_name || "—"}</div>
              <div className="font-mono text-gray-600">{selectedUser.email}</div>
              <div className="text-xs mt-1">
                Identity:{" "}
                <span
                  className={
                    selectedUser.disability_status === "approved"
                      ? "text-green-700 font-medium"
                      : "text-amber-700 font-medium"
                  }
                >
                  {selectedUser.disability_status}
                </span>
              </div>
            </div>
            <Button
              type="button"
              variant="ghost"
              onClick={() => {
                setSelectedUser(null);
                setQuery("");
                setResults([]);
              }}
            >
              Change
            </Button>
          </div>
        ) : (
          <div>
            <div className="relative">
              <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
              <Input
                id="user-search"
                value={query}
                onChange={(e) => setQuery(e.target.value)}
                placeholder="user@example.com or full name"
                className="pl-9"
                autoComplete="off"
              />
            </div>
            <p className="text-xs text-gray-500 mt-1" aria-live="polite">
              {query.trim().length < 2
                ? "Type at least 2 characters."
                : isSearching
                  ? "Searching..."
                  : results.length === 0
                    ? "No users found."
                    : `${results.length} match${results.length === 1 ? "" : "es"}`}
            </p>
            {results.length > 0 && (
              <ul className="mt-2 border rounded-md divide-y max-h-72 overflow-y-auto">
                {results.map((hit) => (
                  <li key={hit.id}>
                    <button
                      type="button"
                      onClick={() => {
                        setSelectedUser(hit);
                        setResults([]);
                        setQuery("");
                      }}
                      className="w-full text-left px-3 py-2 hover:bg-gray-50 focus:bg-blue-50 focus:outline-none"
                    >
                      <div className="text-sm font-medium">
                        {hit.full_name || "(no name)"}
                      </div>
                      <div className="text-xs text-gray-600 font-mono">
                        {hit.email}
                      </div>
                      <div className="text-xs mt-0.5">
                        Identity:{" "}
                        <span
                          className={
                            hit.disability_status === "approved"
                              ? "text-green-700"
                              : "text-amber-700"
                          }
                        >
                          {hit.disability_status}
                        </span>
                      </div>
                    </button>
                  </li>
                ))}
              </ul>
            )}
          </div>
        )}
        {selectedUser && selectedUser.disability_status !== "approved" && (
          <div role="alert" className="bg-amber-50 text-amber-900 p-3 rounded-md text-sm">
            Heads up: this user is not identity-verified. You can still enroll
            them, but they normally should complete{" "}
            <code className="font-mono text-xs">/profile/verify-identity</code>{" "}
            first.
          </div>
        )}
      </div>

      {/* Module picker */}
      <div className="space-y-2">
        <Label htmlFor="module">Course</Label>
        <select
          id="module"
          value={moduleId}
          onChange={(e) => setModuleId(e.target.value)}
          className="w-full border rounded-md px-3 py-2 text-sm"
          required
        >
          <option value="">— Choose a course —</option>
          {modules.map((m) => (
            <option key={m.id} value={m.id}>
              {m.name}
              {m.price_paisa != null
                ? ` — ${m.currency} ${(m.price_paisa / 100).toLocaleString()}`
                : " — Free"}
            </option>
          ))}
        </select>
      </div>

      {/* Amount paid */}
      <div className="space-y-2">
        <Label htmlFor="amount">
          Amount paid ({selectedModule?.currency || "NPR"})
        </Label>
        <Input
          id="amount"
          type="number"
          min="0"
          step="0.01"
          value={amountRupees}
          onChange={(e) => setAmountRupees(e.target.value)}
          required
        />
        <p className="text-xs text-gray-500">
          Pre-filled from the course price; edit if the user paid a different
          amount.
        </p>
      </div>

      {/* Payment reference */}
      <div className="space-y-2">
        <Label htmlFor="payment-reference">Payment reference</Label>
        <Input
          id="payment-reference"
          value={paymentReference}
          onChange={(e) => setPaymentReference(e.target.value)}
          placeholder='e.g. eSewa txn 123456789, "Cash 2026-05-02", receipt #042'
        />
      </div>

      {/* Admin notes */}
      <div className="space-y-2">
        <Label htmlFor="admin-notes">Internal notes (optional)</Label>
        <Textarea
          id="admin-notes"
          value={adminNotes}
          onChange={(e) => setAdminNotes(e.target.value)}
          placeholder="Anything else worth recording — not shown to the user."
        />
      </div>

      <div className="pt-2 border-t">
        <Button
          type="submit"
          disabled={isSubmitting || !selectedUser || !moduleId}
          className="w-full sm:w-auto"
        >
          {isSubmitting ? "Creating..." : "Create enrollment"}
        </Button>
      </div>
    </form>
  );
}

function useDebounced<T>(value: T, ms: number): T {
  const [debounced, setDebounced] = useState(value);
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);
  useEffect(() => {
    if (timer.current) clearTimeout(timer.current);
    timer.current = setTimeout(() => setDebounced(value), ms);
    return () => {
      if (timer.current) clearTimeout(timer.current);
    };
  }, [value, ms]);
  return debounced;
}
