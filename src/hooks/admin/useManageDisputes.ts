import { useState } from "react";
import { useRouter } from "next/navigation";
import toast from "react-hot-toast";

export function useManageDisputes(initialQ: any) {
  const router = useRouter();
  const [q, setQ] = useState(initialQ);
  const [savingKey, setSavingKey] = useState<string | null>(null);

  const updateQuestion = async (updates: any) => {
    setSavingKey('question');
    try {
      const res = await fetch(`/api/questions/${q.id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(updates)
      });
      if (!res.ok) throw new Error("Failed to update question");
      
      const updatedQ = await res.json();
      setQ(updatedQ);
      toast.success("Question fixed successfully");
      return true;
    } catch (e) {
      toast.error("Error updating question");
      return false;
    } finally {
      setSavingKey(null);
    }
  };

  const markResolved = async () => {
    setSavingKey('resolve');
    try {
      const res = await fetch(`/api/reports/${q.id}/resolve`, {
        method: "POST"
      });
      if (!res.ok) throw new Error("Failed to mark as resolved");
      
      toast.success("Dispute resolved!");
      router.push('/admin/disputes');
      router.refresh(); 
    } catch (e) {
      toast.error("Error resolving dispute");
    } finally {
      setSavingKey(null);
    }
  };

  return {
    q,
    savingKey,
    updateQuestion,
    markResolved
  };
}
