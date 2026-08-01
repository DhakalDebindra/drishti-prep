"use client";

import { useState } from "react";
import { 
  Table, 
  TableBody, 
  TableCell, 
  TableHead, 
  TableHeader, 
  TableRow 
} from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { Plus, Pencil, Trash2 } from "lucide-react";
import { 
  Dialog, 
  DialogContent, 
  DialogHeader, 
  DialogTitle 
} from "@/components/ui/dialog";
import { 
  AlertDialog, 
  AlertDialogAction, 
  AlertDialogCancel, 
  AlertDialogContent, 
  AlertDialogDescription, 
  AlertDialogFooter, 
  AlertDialogHeader, 
  AlertDialogTitle 
} from "@/components/ui/alert-dialog";
import { 
  Select, 
  SelectContent, 
  SelectItem, 
  SelectTrigger, 
  SelectValue 
} from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import toast from "react-hot-toast";
import { useRouter } from "next/navigation";
import { Lang } from "@/components/ui/Lang";

interface SubtopicTabProps {
  initialData: any[];
  initialTopics: any[];
}

export function SubtopicTab({ initialData, initialTopics }: SubtopicTabProps) {
  const router = useRouter();
  const [data, setData] = useState(initialData);
  const [isFormOpen, setIsFormOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<any>(null);
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const [formData, setFormData] = useState({
    name: "",
    name_np: "",
    topic_id: "",
    description: "",
    display_order: 0,
  });

  const handleOpenForm = (item: any = null) => {
    if (item) {
      setEditingItem(item);
      setFormData({
        name: item.name || "",
        name_np: item.name_np || "",
        topic_id: item.topic_id || "",
        description: item.description || "",
        display_order: item.display_order || 0,
      });
    } else {
      setEditingItem(null);
      setFormData({
        name: "",
        name_np: "",
        topic_id: initialTopics[0]?.id || "",
        description: "",
        display_order: 0,
      });
    }
    setIsFormOpen(true);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.topic_id) {
        toast.error("Please select a topic");
        return;
    }

    // We don't have /api/subtopics POST/PUT yet. I should create them.
    // Or I can use supabase client directly if this is a client component and user is admin.
    // But better to use the API pattern.
    
    const url = editingItem ? `/api/subtopics/${editingItem.id}` : "/api/subtopics";
    const method = editingItem ? "PUT" : "POST";

    try {
      setIsSubmitting(true);
      const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      const result = await res.json();
      if (!res.ok) throw new Error(result.error || "Failed to save subtopic");

      const enrichedResult = {
          ...result,
          topics: { name: initialTopics.find(t => t.id === result.topic_id)?.name }
      };

      if (editingItem) {
        setData(data.map((item) => (item.id === editingItem.id ? enrichedResult : item)));
        toast.success("Sub-topic updated");
      } else {
        setData([...data, enrichedResult]);
        toast.success("Sub-topic created");
      }
      setIsFormOpen(false);
      router.refresh();
    } catch (error: any) {
      toast.error(error.message);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleDelete = async () => {
    if (!deleteId) return;
    setIsDeleting(true);
    try {
      const res = await fetch(`/api/subtopics/${deleteId}`, { method: "DELETE" });
      if (!res.ok) throw new Error("Failed to delete subtopic");
      setData(data.filter((item) => item.id !== deleteId));
      toast.success("Sub-topic deleted");
    } catch (error: any) {
      toast.error(error.message);
    } finally {
      setIsDeleting(false);
      setDeleteId(null);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex justify-between items-center">
        <h2 className="text-xl font-semibold">Sub-topics (Specific Sections)</h2>
        <Button onClick={() => handleOpenForm()}>
          <Plus className="mr-2 h-4 w-4" /> Add Sub-topic
        </Button>
      </div>

      <div className="rounded-md border">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Sub-topic Name</TableHead>
              <TableHead>Parent Topic</TableHead>
              <TableHead className="w-[100px] text-right">Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {data.length === 0 ? (
              <TableRow>
                <TableCell colSpan={3} className="text-center py-8 text-muted-foreground">
                  No sub-topics found.
                </TableCell>
              </TableRow>
            ) : (
              data.map((item) => (
                <TableRow key={item.id}>
                  <TableCell className="font-medium">
                    <Lang>{item.name_np || item.name}</Lang>
                  </TableCell>
                  <TableCell>
                    <span className="text-xs font-semibold text-slate-500">
                      <Lang>{item.topics?.name || "Unknown"}</Lang>
                    </span>
                  </TableCell>
                  <TableCell className="text-right space-x-2 text-nowrap">
                    <Button variant="ghost" size="icon" onClick={() => handleOpenForm(item)}>
                      <Pencil className="h-4 w-4" />
                    </Button>
                    <Button variant="ghost" size="icon" onClick={() => setDeleteId(item.id)} className="text-destructive">
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>

      <Dialog open={isFormOpen} onOpenChange={setIsFormOpen}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>{editingItem ? "Edit Sub-topic" : "Create New Sub-topic"}</DialogTitle>
          </DialogHeader>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="st-topic">Parent Topic</Label>
              <Select value={formData.topic_id} onValueChange={(val) => setFormData({ ...formData, topic_id: val })}>
                <SelectTrigger id="st-topic">
                  <SelectValue placeholder="Select a topic" />
                </SelectTrigger>
                <SelectContent className="max-h-[300px]">
                  {initialTopics.map(t => (
                      <SelectItem key={t.id} value={t.id} lang="ne">{t.name}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
                <Label htmlFor="st-name-np">Display Name (Nepali)</Label>
                <Input id="st-name-np" lang="ne" value={formData.name_np} onChange={(e) => setFormData({ ...formData, name_np: e.target.value })} placeholder="e.g. राजनीति र शासन" required />
            </div>
            <div className="space-y-2">
                <Label htmlFor="st-name">System Name (English/Slug Base)</Label>
                <Input id="st-name" value={formData.name} onChange={(e) => setFormData({ ...formData, name: e.target.value })} placeholder="e.g. Politics and Governance" required />
            </div>
            <div className="space-y-2">
                <Label htmlFor="st-order">Order</Label>
                <Input id="st-order" type="number" value={formData.display_order} onChange={(e) => setFormData({ ...formData, display_order: parseInt(e.target.value) || 0 })} />
            </div>
            <div className="space-y-2">
              <Label htmlFor="st-desc">Description</Label>
              <Textarea id="st-desc" lang="ne" value={formData.description} onChange={(e) => setFormData({ ...formData, description: e.target.value })} />
            </div>
            <Button type="submit" className="w-full" disabled={isSubmitting}>
              {isSubmitting ? "Saving..." : (editingItem ? "Update Sub-topic" : "Create Sub-topic")}
            </Button>
          </form>
        </DialogContent>
      </Dialog>

      <AlertDialog open={!!deleteId} onOpenChange={(open) => !open && setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader><AlertDialogTitle>Delete Sub-topic?</AlertDialogTitle><AlertDialogDescription>This action cannot be undone.</AlertDialogDescription></AlertDialogHeader>
          <AlertDialogFooter><AlertDialogCancel>Cancel</AlertDialogCancel><AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground" disabled={isDeleting}>{isDeleting ? "Deleting..." : "Delete Sub-topic"}</AlertDialogAction></AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
