"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { ShieldCheck } from "lucide-react";

const DISMISS_KEY = "drishtiprep:identity-prompt-dismissed";

/**
 * First-visit prompt asking the user to verify their identity (disability
 * card). Shown only when the user has not yet submitted a card and has not
 * dismissed the prompt in the current browser session.
 *
 * Accessibility: built on Base UI Dialog (focus trap, ESC to close, aria
 * labelling via DialogTitle/DialogDescription) so it works for screen
 * reader and keyboard users.
 */
export function IdentityVerifyPrompt({
  shouldShow,
}: {
  shouldShow: boolean;
}) {
  const router = useRouter();
  const [open, setOpen] = useState(false);

  useEffect(() => {
    if (!shouldShow) return;
    try {
      if (sessionStorage.getItem(DISMISS_KEY) === "1") return;
    } catch {
      // sessionStorage unavailable (private mode, etc.) — still show.
    }
    // One-time mount-time read of sessionStorage to decide whether to
    // open. This is a legitimate "sync with external system" effect —
    // sessionStorage doesn't emit change events to the same tab, so
    // useSyncExternalStore would not help.
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setOpen(true);
  }, [shouldShow]);

  const dismiss = () => {
    try {
      sessionStorage.setItem(DISMISS_KEY, "1");
    } catch {
      // best-effort
    }
    setOpen(false);
  };

  const proceed = () => {
    try {
      sessionStorage.setItem(DISMISS_KEY, "1");
    } catch {
      // best-effort
    }
    setOpen(false);
    router.push("/profile/verify-identity");
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogContent showCloseButton={false} className="sm:max-w-md">
        <DialogHeader>
          <div className="flex items-center gap-2 text-amber-700 dark:text-amber-300">
            <ShieldCheck className="w-5 h-5" aria-hidden="true" />
            <DialogTitle>Verify your identity</DialogTitle>
          </div>
          <DialogDescription>
            DrishtiPrep is built primarily for visually-impaired aspirants
            preparing for Loksewa and other civil-service exams. To unlock paid
            courses, please submit a photo of your disability card. It's a
            one-time check and usually reviewed within 24 hours.
          </DialogDescription>
        </DialogHeader>
        <DialogFooter>
          <Button variant="outline" onClick={dismiss} size="lg">
            Not now
          </Button>
          <Button onClick={proceed} size="lg">
            Proceed to verify
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
