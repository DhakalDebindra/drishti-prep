import { useState } from "react";
import toast from "react-hot-toast";
import { useRouter } from "next/navigation";

export function useManageQuestionSet(initialSet: any) {
  const [questionSet, setQuestionSet] = useState(initialSet);
  const [savingKey, setSavingKey] = useState<string | null>(null);
  const router = useRouter();

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

  const updateQuestionSet = async (updates: any) => {
    setSavingKey('set');
    try {
      const res = await fetch(`/api/question-sets/${questionSet.id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(updates)
      });
      if (!res.ok) throw new Error("Failed to update question set");
      
      const payload = await res.json();
      setQuestionSet(payload);
      toast.success("Question set updated successfully");
      return payload;
    } catch (e) {
      toast.error("Error updating question set");
      throw e;
    } finally {
      setSavingKey(null);
    }
  };

  const deleteQuestionSet = async () => {
    setSavingKey('deleting');
    try {
      const res = await fetch(`/api/question-sets/${questionSet.id}`, {
        method: "DELETE"
      });
      const data = await res.json();
      
      if (!res.ok) {
        throw new Error(data.error || "Failed to delete question set");
      }
      
      toast.success("Question set deleted successfully");
      router.push("/admin");
    } catch (e: any) {
      console.error("Delete Error:", e);
      toast.error(e.message || "Error deleting question set");
    } finally {
      setSavingKey(null);
    }
  };

  return {
    questionSet,
    savingKey,
    togglePublishStatus,
    updateQuestionSet,
    deleteQuestionSet
  };
}
