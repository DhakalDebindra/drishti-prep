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
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import toast from "react-hot-toast";
import { useRouter } from "next/navigation";
import { Lang } from "@/components/ui/Lang";

interface ModuleTabProps {
  initialData: any[];
}

export function ModuleTab({ initialData }: ModuleTabProps) {
  const router = useRouter();
  const [data, setData] = useState(initialData);
  const [isFormOpen, setIsFormOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<any>(null);
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);

  const [formData, setFormData] = useState({
    name: "",
    slug: "",
    name_np: "",
    description: "",
    display_order: 0,
  });

  const handleOpenForm = (item: any = null) => {
    if (item) {
      setEditingItem(item);
      setFormData({
        name: item.name || "",
        slug: item.slug || "",
        name_np: item.name_np || "",
        description: item.description || "",
        display_order: item.display_order || 0,
      });
    } else {
      setEditingItem(null);
      setFormData({
        name: "",
        slug: "",
        name_np: "",
        description: "",
        display_order: 0,
      });
    }
    setIsFormOpen(true);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const url = editingItem ? `/api/modules/${editingItem.id}` : "/api/modules";
    const method = editingItem ? "PUT" : "POST";

    try {
      const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      const result = await res.json();
      if (!res.ok) throw new Error(result.error || "Failed to save module");

      if (editingItem) {
        setData(data.map((item) => (item.id === editingItem.id ? result : item)));
        toast.success("Module updated successfully");
      } else {
        setData([...data, result]);
        toast.success("Module created successfully");
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
      const res = await fetch(`/api/modules/${deleteId}`, { method: "DELETE" });
      const result = await res.json();

      if (!res.ok) {
        throw new Error(result.error || "Failed to delete module");
      }

      setData(data.filter((item) => item.id !== deleteId));
      toast.success("Module deleted successfully");
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
        <h2 className="text-xl font-semibold">Modules</h2>
        <Button onClick={() => handleOpenForm()}>
          <Plus className="mr-2 h-4 w-4" /> Add Module
        </Button>
      </div>

      <div className="rounded-md border">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Display Name</TableHead>
              <TableHead>Nepali Name</TableHead>
              <TableHead>Slug</TableHead>
              <TableHead className="w-[100px] text-right">Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {data.length === 0 ? (
              <TableRow>
                <TableCell colSpan={4} className="text-center py-8 text-muted-foreground">
                  No modules found. Create one to get started.
                </TableCell>
              </TableRow>
            ) : (
              data.map((module) => (
                <TableRow key={module.id}>
                  <TableCell className="font-medium">{module.name}</TableCell>
                  <TableCell><Lang>{module.name_np || "-"}</Lang></TableCell>
                  <TableCell className="font-mono text-xs">{module.slug}</TableCell>
                  <TableCell className="text-right space-x-2">
                    <Button 
                      variant="ghost" 
                      size="icon" 
                      onClick={() => handleOpenForm(module)}
                      aria-label={`Edit ${module.name}`}
                    >
                      <Pencil className="h-4 w-4" />
                    </Button>
                    <Button 
                      variant="ghost" 
                      size="icon" 
                      onClick={() => setDeleteId(module.id)}
                      className="text-destructive"
                      aria-label={`Delete ${module.name}`}
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
            <DialogTitle>{editingItem ? "Edit Module" : "Create New Module"}</DialogTitle>
          </DialogHeader>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="name">Display Name (English)</Label>
              <Input 
                id="name" 
                value={formData.name} 
                onChange={(e) => setFormData({ ...formData, name: e.target.value })} 
                required 
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="name_np">Display Name (Nepali)</Label>
              <Input 
                id="name_np" 
                lang="ne"
                value={formData.name_np} 
                onChange={(e) => setFormData({ ...formData, name_np: e.target.value })} 
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="slug">Slug (Unique identifier)</Label>
              <Input 
                id="slug" 
                value={formData.slug} 
                onChange={(e) => setFormData({ ...formData, slug: e.target.value })} 
                placeholder="e.g. gk, Kharidar"
                required 
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="description">Description</Label>
              <Textarea 
                id="description" 
                lang="ne"
                value={formData.description} 
                onChange={(e) => setFormData({ ...formData, description: e.target.value })} 
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="display_order">Display Order</Label>
              <Input 
                id="display_order" 
                type="number"
                value={formData.display_order} 
                onChange={(e) => setFormData({ ...formData, display_order: parseInt(e.target.value) })} 
              />
            </div>
            <Button type="submit" className="w-full">
              {editingItem ? "Update Module" : "Create Module"}
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
              This will permanently delete the module. This action cannot be undone.
              Safe delete check will prevent deletion if this module contains subjects.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction 
              onClick={handleDelete} 
              className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
              disabled={isDeleting}
            >
              {isDeleting ? "Deleting..." : "Delete Module"}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
