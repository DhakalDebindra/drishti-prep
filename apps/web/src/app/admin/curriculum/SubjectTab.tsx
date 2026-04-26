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
import { Plus, Pencil, Trash2, BookOpen } from "lucide-react";
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
import { Lang } from "@/components/ui/Lang";

interface SubjectTabProps {
  initialData: any[];
  initialModules: any[];
}

export function SubjectTab({ initialData, initialModules }: SubjectTabProps) {
  const router = useRouter();
  const [data, setData] = useState(initialData);
  const [isFormOpen, setIsFormOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<any>(null);
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);

  const [formData, setFormData] = useState({
    name: "",
    name_np: "",
    module_id: "",
    syllabus_ref: "",
    description: "",
    display_order: 0,
  });

  const handleOpenForm = (item: any = null) => {
    if (item) {
      setEditingItem(item);
      setFormData({
        name: item.name || "",
        name_np: item.name_np || "",
        module_id: item.module_id || "",
        syllabus_ref: item.syllabus_ref || "",
        description: item.description || "",
        display_order: item.display_order || 0,
      });
    } else {
      setEditingItem(null);
      setFormData({
        name: "",
        name_np: "",
        module_id: initialModules[0]?.id || "",
        syllabus_ref: "",
        description: "",
        display_order: 0,
      });
    }
    setIsFormOpen(true);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.module_id) {
        toast.error("Please select a module");
        return;
    }

    const url = editingItem ? `/api/subjects/${editingItem.id}` : "/api/subjects";
    const method = editingItem ? "PUT" : "POST";

    try {
      const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      const result = await res.json();
      if (!res.ok) throw new Error(result.error || "Failed to save subject");

      // We need to re-fetch or manually enrich with module name if needed
      // For simplicity, we can reload or manual patch
      const enrichedResult = {
          ...result,
          modules: { name: initialModules.find(m => m.id === result.module_id)?.name }
      };

      if (editingItem) {
        setData(data.map((item) => (item.id === editingItem.id ? enrichedResult : item)));
        toast.success("Subject updated successfully");
      } else {
        setData([...data, enrichedResult]);
        toast.success("Subject created successfully");
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
      const res = await fetch(`/api/subjects/${deleteId}`, { method: "DELETE" });
      const result = await res.json();

      if (!res.ok) {
        throw new Error(result.error || "Failed to delete subject");
      }

      setData(data.filter((item) => item.id !== deleteId));
      toast.success("Subject deleted successfully");
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
        <h2 className="text-xl font-semibold">Subjects</h2>
        <Button onClick={() => handleOpenForm()}>
          <Plus className="mr-2 h-4 w-4" /> Add Subject
        </Button>
      </div>

      <div className="rounded-md border">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Ref</TableHead>
              <TableHead>Name (English/Nepali)</TableHead>
              <TableHead>Module</TableHead>
              <TableHead className="w-[100px] text-right">Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {data.length === 0 ? (
              <TableRow>
                <TableCell colSpan={4} className="text-center py-8 text-muted-foreground">
                  No subjects found.
                </TableCell>
              </TableRow>
            ) : (
              data.map((subject) => (
                <TableRow key={subject.id}>
                  <TableCell className="font-mono text-xs">{subject.syllabus_ref || "-"}</TableCell>
                  <TableCell>
                    <div className="flex flex-col">
                        <span className="font-medium">{subject.name}</span>
                        <span className="text-xs text-muted-foreground"><Lang>{subject.name_np}</Lang></span>
                    </div>
                  </TableCell>
                  <TableCell>
                    <span className="inline-flex items-center rounded-full bg-blue-50 px-2 py-1 text-xs font-medium text-blue-700 ring-1 ring-inset ring-blue-700/10">
                        <Lang>{subject.modules?.name || "Unknown"}</Lang>
                    </span>
                  </TableCell>
                  <TableCell className="text-right space-x-2">
                    <Button 
                      variant="ghost" 
                      size="icon" 
                      onClick={() => handleOpenForm(subject)}
                      aria-label={`Edit ${subject.name}`}
                    >
                      <Pencil className="h-4 w-4" />
                    </Button>
                    <Button 
                      variant="ghost" 
                      size="icon" 
                      onClick={() => setDeleteId(subject.id)}
                      className="text-destructive"
                      aria-label={`Delete ${subject.name}`}
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
            <DialogTitle>{editingItem ? "Edit Subject" : "Create New Subject"}</DialogTitle>
          </DialogHeader>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="s-module">Module</Label>
              <Select 
                value={formData.module_id} 
                onValueChange={(val) => setFormData({ ...formData, module_id: val })}
              >
                <SelectTrigger id="s-module">
                  <SelectValue placeholder="Select a module" />
                </SelectTrigger>
                <SelectContent>
                  {initialModules.map(m => (
                      <SelectItem key={m.id} value={m.id} lang="ne">{m.name}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                    <Label htmlFor="s-name">English Name</Label>
                    <Input 
                        id="s-name" 
                        value={formData.name} 
                        onChange={(e) => setFormData({ ...formData, name: e.target.value })} 
                        required 
                    />
                </div>
                <div className="space-y-2">
                    <Label htmlFor="s-name_np">Nepali Name</Label>
                    <Input 
                        id="s-name_np" 
                        lang="ne"
                        value={formData.name_np} 
                        onChange={(e) => setFormData({ ...formData, name_np: e.target.value })} 
                    />
                </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                    <Label htmlFor="s-ref">Syllabus Reference</Label>
                    <Input 
                        id="s-ref" 
                        value={formData.syllabus_ref} 
                        onChange={(e) => setFormData({ ...formData, syllabus_ref: e.target.value })} 
                        placeholder="e.g. 1.1"
                    />
                </div>
                <div className="space-y-2">
                    <Label htmlFor="s-order">Display Order</Label>
                    <Input 
                        id="s-order" 
                        type="number"
                        value={formData.display_order} 
                        onChange={(e) => setFormData({ ...formData, display_order: parseInt(e.target.value) })} 
                    />
                </div>
            </div>
            <div className="space-y-2">
              <Label htmlFor="s-desc">Description</Label>
              <Textarea 
                id="s-desc" 
                lang="ne"
                value={formData.description} 
                onChange={(e) => setFormData({ ...formData, description: e.target.value })} 
              />
            </div>
            <Button type="submit" className="w-full">
              {editingItem ? "Update Subject" : "Create Subject"}
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
              This will permanently delete the subject. 
              Safe delete check will prevent deletion if this subject contains topics.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction 
              onClick={handleDelete} 
              className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
              disabled={isDeleting}
            >
              {isDeleting ? "Deleting..." : "Delete Subject"}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
