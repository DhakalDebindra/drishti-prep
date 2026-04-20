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
  DialogTitle, 
  DialogTrigger 
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

interface TopicTabProps {
  initialData: any[];
  initialSubjects: any[];
}

export function TopicTab({ initialData, initialSubjects }: TopicTabProps) {
  const router = useRouter();
  const [data, setData] = useState(initialData);
  const [isFormOpen, setIsFormOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<any>(null);
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);

  const [formData, setFormData] = useState({
    name: "",
    subject_id: "",
    syllabus_ref: "",
    description: "",
    display_order: 0,
  });

  const handleOpenForm = (item: any = null) => {
    if (item) {
      setEditingItem(item);
      setFormData({
        name: item.name || "",
        subject_id: item.subject_id || "",
        syllabus_ref: item.syllabus_ref || "",
        description: item.description || "",
        display_order: item.display_order || 0,
      });
    } else {
      setEditingItem(null);
      setFormData({
        name: "",
        subject_id: initialSubjects[0]?.id || "",
        syllabus_ref: "",
        description: "",
        display_order: 0,
      });
    }
    setIsFormOpen(true);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.subject_id) {
        toast.error("Please select a subject");
        return;
    }

    const url = editingItem ? `/api/topics/${editingItem.id}` : "/api/topics";
    const method = editingItem ? "PUT" : "POST";

    try {
      const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      const result = await res.json();
      if (!res.ok) throw new Error(result.error || "Failed to save topic");

      const enrichedResult = {
          ...result,
          subjects: { name: initialSubjects.find(s => s.id === result.subject_id)?.name }
      };

      if (editingItem) {
        setData(data.map((item) => (item.id === editingItem.id ? enrichedResult : item)));
        toast.success("Topic updated successfully");
      } else {
        setData([...data, enrichedResult]);
        toast.success("Topic created successfully");
      }
      setIsFormOpen(false);
      router.refresh();
    } catch (error: any) {
      toast.error(error.message);
    }
  };

  const handleDelete = async () => {
    if (!deleteId) return;
    setIsDeleting(true);
    try {
      const res = await fetch(`/api/topics/${deleteId}`, { method: "DELETE" });
      const result = await res.json();

      if (!res.ok) {
        throw new Error(result.error || "Failed to delete topic");
      }

      setData(data.filter((item) => item.id !== deleteId));
      toast.success("Topic deleted successfully");
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
        <h2 className="text-xl font-semibold">Topics (Sub-chapters)</h2>
        <Button onClick={() => handleOpenForm()}>
          <Plus className="mr-2 h-4 w-4" /> Add Topic
        </Button>
      </div>

      <div className="rounded-md border">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Ref</TableHead>
              <TableHead>Topic Name</TableHead>
              <TableHead>Subject</TableHead>
              <TableHead className="w-[100px] text-right">Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {data.length === 0 ? (
              <TableRow>
                <TableCell colSpan={4} className="text-center py-8 text-muted-foreground">
                  No topics found.
                </TableCell>
              </TableRow>
            ) : (
              data.map((topic) => (
                <TableRow key={topic.id}>
                  <TableCell className="font-mono text-xs text-muted-foreground">{topic.syllabus_ref || "-"}</TableCell>
                  <TableCell className="font-medium">{topic.name}</TableCell>
                  <TableCell>
                    <span className="text-xs">{topic.subjects?.name || "Unknown"}</span>
                  </TableCell>
                  <TableCell className="text-right space-x-2 text-nowrap">
                    <Button 
                      variant="ghost" 
                      size="icon" 
                      onClick={() => handleOpenForm(topic)}
                      aria-label={`Edit ${topic.name}`}
                    >
                      <Pencil className="h-4 w-4" />
                    </Button>
                    <Button 
                      variant="ghost" 
                      size="icon" 
                      onClick={() => setDeleteId(topic.id)}
                      className="text-destructive"
                      aria-label={`Delete ${topic.name}`}
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>

      {/* Form Dialog */}
      <Dialog open={isFormOpen} onOpenChange={setIsFormOpen}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>{editingItem ? "Edit Topic" : "Create New Topic"}</DialogTitle>
          </DialogHeader>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="t-subject">Parent Subject</Label>
              <Select 
                value={formData.subject_id} 
                onValueChange={(val) => setFormData({ ...formData, subject_id: val })}
              >
                <SelectTrigger id="t-subject">
                  <SelectValue placeholder="Select a subject" />
                </SelectTrigger>
                <SelectContent className="max-h-[300px]">
                  {initialSubjects.map(s => (
                      <SelectItem key={s.id} value={s.id}>{s.name}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
                <Label htmlFor="t-name">Topic Name</Label>
                <Input 
                    id="t-name" 
                    value={formData.name} 
                    onChange={(e) => setFormData({ ...formData, name: e.target.value })} 
                    placeholder="e.g. सौर्यमण्डल"
                    required 
                />
            </div>
            <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                    <Label htmlFor="t-ref">Syllabus Ref</Label>
                    <Input 
                        id="t-ref" 
                        value={formData.syllabus_ref} 
                        onChange={(e) => setFormData({ ...formData, syllabus_ref: e.target.value })} 
                        placeholder="e.g. 1.1.1"
                    />
                </div>
                <div className="space-y-2">
                    <Label htmlFor="t-order">Order</Label>
                    <Input 
                        id="t-order" 
                        type="number"
                        value={formData.display_order} 
                        onChange={(e) => setFormData({ ...formData, display_order: parseInt(e.target.value) })} 
                    />
                </div>
            </div>
            <div className="space-y-2">
              <Label htmlFor="t-desc">Description</Label>
              <Textarea 
                id="t-desc" 
                value={formData.description} 
                onChange={(e) => setFormData({ ...formData, description: e.target.value })} 
              />
            </div>
            <Button type="submit" className="w-full">
              {editingItem ? "Update Topic" : "Create Topic"}
            </Button>
          </form>
        </DialogContent>
      </Dialog>

      {/* Delete Confirmation */}
      <AlertDialog open={!!deleteId} onOpenChange={(open) => !open && setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
            <AlertDialogDescription>
              This will permanently delete the topic. 
              Safe delete check will prevent deletion if this topic contains question sets.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction 
              onClick={handleDelete} 
              className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
              disabled={isDeleting}
            >
              {isDeleting ? "Deleting..." : "Delete Topic"}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
