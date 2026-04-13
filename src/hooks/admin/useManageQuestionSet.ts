import { useState } from "react";
import toast from "react-hot-toast";

export function useManageQuestionSet(initialSet: any) {
  const [questionSet, setQuestionSet] = useState(initialSet);
  const [savingKey, setSavingKey] = useState<string | null>(null);

  const togglePublishStatus = async () => {
    setSavingKey('set');
    const newStatus = !questionSet.is_verified;
    try {
      const res = await fetch(`/api/question-sets/${questionSet.id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ is_verified: newStatus })
      });
      if (!res.ok) throw new Error("Failed to update status");
      
      const payload = await res.json();
      setQuestionSet(payload);
      toast.success(newStatus ? "Set published successfully" : "Set reverted to draft");
    } catch (e) {
      toast.error("Error updating status");
    } finally {
      setSavingKey(null);
    }
  };

  return {
    questionSet,
    savingKey,
    togglePublishStatus
  };
}
