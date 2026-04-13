import { useState } from "react";
import toast from "react-hot-toast";

export function useManageQuestions(initialQuestions: any[]) {
  const [questions, setQuestions] = useState(initialQuestions);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [savingKey, setSavingKey] = useState<string | null>(null);

  const updateQuestion = async (id: string, updates: any) => {
    setSavingKey(id);
    try {
      const res = await fetch(`/api/questions/${id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(updates)
      });
      if (!res.ok) throw new Error("Failed to update question");
      
      const updatedQ = await res.json();
      setQuestions(prev => prev.map(q => q.id === id ? updatedQ : q));
      setEditingId(null);
      toast.success("Question updated successfully");
    } catch (e) {
      toast.error("Error updating question");
    } finally {
      setSavingKey(null);
    }
  };

  const moveQuestion = async (index: number, direction: 'up' | 'down') => {
    if (direction === 'up' && index === 0) return;
    if (direction === 'down' && index === questions.length - 1) return;

    const newQuestions = [...questions];
    const swapIndex = direction === 'up' ? index - 1 : index + 1;
    
    // Swap order_number
    const tempOrder = newQuestions[index].order_number;
    newQuestions[index].order_number = newQuestions[swapIndex].order_number;
    newQuestions[swapIndex].order_number = tempOrder;

    // Swap position in array for optimistic UI
    const tempQ = newQuestions[index];
    newQuestions[index] = newQuestions[swapIndex];
    newQuestions[swapIndex] = tempQ;
    
    setQuestions(newQuestions);

    // Save both
    await Promise.all([
      fetch(`/api/questions/${newQuestions[index].id}`, {
        method: "PATCH",
        headers:{ "Content-Type" : "application/json" },
        body: JSON.stringify({ order_number: newQuestions[index].order_number })
      }),
      fetch(`/api/questions/${newQuestions[swapIndex].id}`, {
        method: "PATCH",
        headers:{ "Content-Type" : "application/json" },
        body: JSON.stringify({ order_number: newQuestions[swapIndex].order_number })
      })
    ]);
  };

  return {
    questions,
    editingId,
    savingKey,
    setEditingId,
    updateQuestion,
    moveQuestion
  };
}
