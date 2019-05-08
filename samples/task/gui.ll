
; __CLANG_OFFLOAD_BUNDLE____START__ openmp-x86_64-unknown-linux-gnu
; ModuleID = 'gui.cpp'
source_filename = "gui.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__tgt_offload_entry = type { i8*, i8*, i8*, i64, i32, i32, i32 }

@.omp_offloading.entry_name = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_122265a_main_l13\00"
@.omp_offloading.entry_module = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_122265a_main_l13 = weak constant %struct.__tgt_offload_entry { i8* bitcast (void ([3 x i32]*)* @__omp_offloading_806_122265a_main_l13 to i8*), i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entry_name.1 = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_122265a_main_l17\00"
@.omp_offloading.entry_module.2 = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_122265a_main_l17 = weak constant %struct.__tgt_offload_entry { i8* bitcast (void ([3 x i32]*)* @__omp_offloading_806_122265a_main_l17 to i8*), i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module.2, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1

; Function Attrs: noinline nounwind uwtable
define weak void @__omp_offloading_806_122265a_main_l13([3 x i32]* dereferenceable(12) %A) #0 {
entry:
  %A.addr = alloca [3 x i32]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store [3 x i32]* %A, [3 x i32]** %A.addr, align 8
  %0 = load [3 x i32]*, [3 x i32]** %A.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc4, %entry
  %1 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %1, 9999
  br i1 %cmp, label %for.body, label %for.end6

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %2 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %2, 9999
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %arrayidx = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 0
  store i32 888, i32* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %3 = load i32, i32* %j, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc4

for.inc4:                                         ; preds = %for.end
  %4 = load i32, i32* %i, align 4
  %inc5 = add nsw i32 %4, 1
  store i32 %inc5, i32* %i, align 4
  br label %for.cond

for.end6:                                         ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind uwtable
define weak void @__omp_offloading_806_122265a_main_l17([3 x i32]* dereferenceable(12) %A) #0 {
entry:
  %A.addr = alloca [3 x i32]*, align 8
  store [3 x i32]* %A, [3 x i32]** %A.addr, align 8
  %0 = load [3 x i32]*, [3 x i32]** %A.addr, align 8
  %arrayidx = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 0
  %1 = load i32, i32* %arrayidx, align 4
  %add = add nsw i32 %1, 777
  store i32 %add, i32* %arrayidx, align 4
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!omp_offload.info = !{!0, !1}
!llvm.module.flags = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 0, i32 2054, i32 19015258, !"main", i32 13, i32 0}
!1 = !{i32 0, i32 2054, i32 19015258, !"main", i32 17, i32 1}
!2 = !{i32 1, !"PIC Level", i32 2}
!3 = !{!"clang version 4.0.0 "}

; __CLANG_OFFLOAD_BUNDLE____END__ openmp-x86_64-unknown-linux-gnu

; __CLANG_OFFLOAD_BUNDLE____START__ openmp-nvptx64-nvidia-cuda
; ModuleID = 'gui.cpp'
source_filename = "gui.cpp"
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

%struct.__openmp_nvptx_target_property_ty = type { i8, i32, i32 }
%struct.__openmp_nvptx_target_property_ty.0 = type { i8, i32, i32 }

@__omp_offloading_806_122265a_main_l13_property = weak constant %struct.__openmp_nvptx_target_property_ty { i8 1, i32 0, i32 0 }, align 1
@__omp_offloading_806_122265a_main_l17_property = weak constant %struct.__openmp_nvptx_target_property_ty.0 { i8 1, i32 0, i32 0 }, align 1

declare void @__kmpc_kernel_deinit(i16)

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() #0

; Function Attrs: noinline nounwind
define weak void @__omp_offloading_806_122265a_main_l13([3 x i32]* dereferenceable(12) %A, i8* %scratchpad_ptr) #1 {
entry:
  %A.addr.i = alloca [3 x i32]*, align 8
  %i.i = alloca i32, align 4
  %j.i = alloca i32, align 4
  %A.addr = alloca [3 x i32]*, align 8
  %scratchpad_ptr.addr = alloca i8*, align 8
  store [3 x i32]* %A, [3 x i32]** %A.addr, align 8
  store i8* %scratchpad_ptr, i8** %scratchpad_ptr.addr, align 8
  %0 = load [3 x i32]*, [3 x i32]** %A.addr, align 8
  %1 = call i32 @__omp_kernel_initialization() #3
  %2 = icmp eq i32 %1, 1
  br i1 %2, label %.master.i, label %__omp_offloading_806_122265a_main_l13_impl__.exit

.master.i:                                        ; preds = %entry
  store [3 x i32]* %0, [3 x i32]** %A.addr.i, align 8
  %3 = load [3 x i32]*, [3 x i32]** %A.addr.i, align 8
  store i32 0, i32* %i.i, align 4
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.end.i, %.master.i
  %4 = load i32, i32* %i.i, align 4
  %cmp.i = icmp slt i32 %4, 9999
  br i1 %cmp.i, label %for.body.i, label %for.end6.i

for.body.i:                                       ; preds = %for.cond.i
  store i32 0, i32* %j.i, align 4
  br label %for.cond1.i

for.cond1.i:                                      ; preds = %for.body3.i, %for.body.i
  %5 = load i32, i32* %j.i, align 4
  %cmp2.i = icmp slt i32 %5, 9999
  br i1 %cmp2.i, label %for.body3.i, label %for.end.i

for.body3.i:                                      ; preds = %for.cond1.i
  %arrayidx.i = getelementptr inbounds [3 x i32], [3 x i32]* %3, i64 0, i64 0
  store i32 888, i32* %arrayidx.i, align 4
  %6 = load i32, i32* %j.i, align 4
  %inc.i = add nsw i32 %6, 1
  store i32 %inc.i, i32* %j.i, align 4
  br label %for.cond1.i

for.end.i:                                        ; preds = %for.cond1.i
  %7 = load i32, i32* %i.i, align 4
  %inc5.i = add nsw i32 %7, 1
  store i32 %inc5.i, i32* %i.i, align 4
  br label %for.cond.i

for.end6.i:                                       ; preds = %for.cond.i
  call void @__kmpc_kernel_deinit(i16 0) #3
  call void @llvm.nvvm.barrier0() #3
  br label %__omp_offloading_806_122265a_main_l13_impl__.exit

__omp_offloading_806_122265a_main_l13_impl__.exit: ; preds = %entry, %for.end6.i
  ret void
}

declare i1 @__kmpc_kernel_parallel(i8**, i16)

; Function Attrs: noinline nounwind
define weak void @__omp_offloading_806_122265a_main_l17([3 x i32]* dereferenceable(12) %A, i8* %scratchpad_ptr) #1 {
entry:
  %A.addr.i = alloca [3 x i32]*, align 8
  %A.addr = alloca [3 x i32]*, align 8
  %scratchpad_ptr.addr = alloca i8*, align 8
  store [3 x i32]* %A, [3 x i32]** %A.addr, align 8
  store i8* %scratchpad_ptr, i8** %scratchpad_ptr.addr, align 8
  %0 = load [3 x i32]*, [3 x i32]** %A.addr, align 8
  %1 = call i32 @__omp_kernel_initialization.1() #3
  %2 = icmp eq i32 %1, 1
  br i1 %2, label %.master.i, label %__omp_offloading_806_122265a_main_l17_impl__.exit

.master.i:                                        ; preds = %entry
  store [3 x i32]* %0, [3 x i32]** %A.addr.i, align 8
  %3 = load [3 x i32]*, [3 x i32]** %A.addr.i, align 8
  %arrayidx.i = getelementptr inbounds [3 x i32], [3 x i32]* %3, i64 0, i64 0
  %4 = load i32, i32* %arrayidx.i, align 4
  %add.i = add nsw i32 %4, 777
  store i32 %add.i, i32* %arrayidx.i, align 4
  call void @__kmpc_kernel_deinit(i16 0) #3
  call void @llvm.nvvm.barrier0() #3
  br label %__omp_offloading_806_122265a_main_l17_impl__.exit

__omp_offloading_806_122265a_main_l17_impl__.exit: ; preds = %entry, %.master.i
  ret void
}

; Function Attrs: noinline nounwind
define internal i32 @__omp_kernel_initialization() #1 {
entry:
  %work_fn.i = alloca i8*, align 8
  %exec_status.i = alloca i8, align 1
  %retval = alloca i32, align 4
  %nvptx_num_threads = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !range !11
  %nvptx_warp_size = call i32 @llvm.nvvm.read.ptx.sreg.warpsize(), !range !12
  %thread_limit = sub i32 %nvptx_num_threads, %nvptx_warp_size
  call void @__kmpc_kernel_init(i32 %thread_limit, i16 0)
  %nvptx_tid = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !13
  %nvptx_num_threads1 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !range !11
  %nvptx_warp_size2 = call i32 @llvm.nvvm.read.ptx.sreg.warpsize(), !range !12
  %0 = sub i32 %nvptx_warp_size2, 1
  %1 = sub i32 %nvptx_num_threads1, 1
  %2 = xor i32 %0, -1
  %master_tid = and i32 %1, %2
  %3 = icmp eq i32 %nvptx_tid, %master_tid
  %conv = zext i1 %3 to i32
  store i32 %conv, i32* %retval, align 4
  %nvptx_tid3 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !13
  %nvptx_num_threads4 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !range !11
  %nvptx_warp_size5 = call i32 @llvm.nvvm.read.ptx.sreg.warpsize(), !range !12
  %thread_limit6 = sub i32 %nvptx_num_threads4, %nvptx_warp_size5
  %4 = icmp ult i32 %nvptx_tid3, %thread_limit6
  br i1 %4, label %.worker, label %.exit

.worker:                                          ; preds = %entry
  store i8 0, i8* %exec_status.i, align 1
  br label %.await.work.i

.await.work.i:                                    ; preds = %.barrier.parallel.i, %.worker
  call void @llvm.nvvm.barrier0() #3
  %5 = call i1 @__kmpc_kernel_parallel(i8** %work_fn.i, i16 0) #3
  %6 = zext i1 %5 to i8
  store i8 %6, i8* %exec_status.i, align 1
  %7 = load volatile i8*, i8** %work_fn.i, align 8
  %should_terminate.i = icmp eq i8* %7, null
  br i1 %should_terminate.i, label %__omp_offloading_806_122265a_main_l13_worker.exit, label %.select.workers.i

.select.workers.i:                                ; preds = %.await.work.i
  %8 = load i8, i8* %exec_status.i, align 1
  %is_active.i = icmp ne i8 %8, 0
  br i1 %is_active.i, label %.execute.parallel.i, label %.barrier.parallel.i

.execute.parallel.i:                              ; preds = %.select.workers.i
  br label %.barrier.parallel.i

.barrier.parallel.i:                              ; preds = %.execute.parallel.i, %.select.workers.i
  call void @llvm.nvvm.barrier0() #3
  br label %.await.work.i

__omp_offloading_806_122265a_main_l13_worker.exit: ; preds = %.await.work.i
  br label %.exit

.exit:                                            ; preds = %__omp_offloading_806_122265a_main_l13_worker.exit, %entry
  %9 = load i32, i32* %retval, align 4
  ret i32 %9
}

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.warpsize() #2

declare void @__kmpc_kernel_init(i32, i16)

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #2

; Function Attrs: noinline nounwind
define internal i32 @__omp_kernel_initialization.1() #1 {
entry:
  %work_fn.i = alloca i8*, align 8
  %exec_status.i = alloca i8, align 1
  %retval = alloca i32, align 4
  %nvptx_num_threads = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !range !11
  %nvptx_warp_size = call i32 @llvm.nvvm.read.ptx.sreg.warpsize(), !range !12
  %thread_limit = sub i32 %nvptx_num_threads, %nvptx_warp_size
  call void @__kmpc_kernel_init(i32 %thread_limit, i16 0)
  %nvptx_tid = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !13
  %nvptx_num_threads1 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !range !11
  %nvptx_warp_size2 = call i32 @llvm.nvvm.read.ptx.sreg.warpsize(), !range !12
  %0 = sub i32 %nvptx_warp_size2, 1
  %1 = sub i32 %nvptx_num_threads1, 1
  %2 = xor i32 %0, -1
  %master_tid = and i32 %1, %2
  %3 = icmp eq i32 %nvptx_tid, %master_tid
  %conv = zext i1 %3 to i32
  store i32 %conv, i32* %retval, align 4
  %nvptx_tid3 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !13
  %nvptx_num_threads4 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !range !11
  %nvptx_warp_size5 = call i32 @llvm.nvvm.read.ptx.sreg.warpsize(), !range !12
  %thread_limit6 = sub i32 %nvptx_num_threads4, %nvptx_warp_size5
  %4 = icmp ult i32 %nvptx_tid3, %thread_limit6
  br i1 %4, label %.worker, label %.exit

.worker:                                          ; preds = %entry
  store i8 0, i8* %exec_status.i, align 1
  br label %.await.work.i

.await.work.i:                                    ; preds = %.barrier.parallel.i, %.worker
  call void @llvm.nvvm.barrier0() #3
  %5 = call i1 @__kmpc_kernel_parallel(i8** %work_fn.i, i16 0) #3
  %6 = zext i1 %5 to i8
  store i8 %6, i8* %exec_status.i, align 1
  %7 = load volatile i8*, i8** %work_fn.i, align 8
  %should_terminate.i = icmp eq i8* %7, null
  br i1 %should_terminate.i, label %__omp_offloading_806_122265a_main_l17_worker.exit, label %.select.workers.i

.select.workers.i:                                ; preds = %.await.work.i
  %8 = load i8, i8* %exec_status.i, align 1
  %is_active.i = icmp ne i8 %8, 0
  br i1 %is_active.i, label %.execute.parallel.i, label %.barrier.parallel.i

.execute.parallel.i:                              ; preds = %.select.workers.i
  br label %.barrier.parallel.i

.barrier.parallel.i:                              ; preds = %.execute.parallel.i, %.select.workers.i
  call void @llvm.nvvm.barrier0() #3
  br label %.await.work.i

__omp_offloading_806_122265a_main_l17_worker.exit: ; preds = %.await.work.i
  br label %.exit

.exit:                                            ; preds = %__omp_offloading_806_122265a_main_l17_worker.exit, %entry
  %9 = load i32, i32* %retval, align 4
  ret i32 %9
}

attributes #0 = { convergent nounwind }
attributes #1 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_50" "target-features"="+ptx60,-satom" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!omp_offload.info = !{!0, !1}
!nvvm.annotations = !{!2, !3, !4, !5, !4, !6, !6, !6, !6, !7, !7, !6}
!llvm.module.flags = !{!8}
!llvm.ident = !{!9}
!nvvm.internalize.after.link = !{}
!nvvmir.version = !{!10}

!0 = !{i32 0, i32 2054, i32 19015258, !"main", i32 13, i32 0}
!1 = !{i32 0, i32 2054, i32 19015258, !"main", i32 17, i32 1}
!2 = !{void ([3 x i32]*, i8*)* @__omp_offloading_806_122265a_main_l13, !"kernel", i32 1}
!3 = !{void ([3 x i32]*, i8*)* @__omp_offloading_806_122265a_main_l17, !"kernel", i32 1}
!4 = !{null, !"align", i32 8}
!5 = !{null, !"align", i32 8, !"align", i32 65544, !"align", i32 131080}
!6 = !{null, !"align", i32 16}
!7 = !{null, !"align", i32 16, !"align", i32 65552, !"align", i32 131088}
!8 = !{i32 1, !"PIC Level", i32 2}
!9 = !{!"clang version 4.0.0 "}
!10 = !{i32 1, i32 2}
!11 = !{i32 1, i32 1025}
!12 = !{i32 32, i32 33}
!13 = !{i32 0, i32 1024}

; __CLANG_OFFLOAD_BUNDLE____END__ openmp-nvptx64-nvidia-cuda

; __CLANG_OFFLOAD_BUNDLE____START__ host-x86_64-unknown-linux-gnu
; ModuleID = '/tmp/gui-8006f0.bc'
source_filename = "gui.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct.__tgt_offload_entry = type { i8*, i8*, i8*, i64, i32, i32, i32 }
%struct.__tgt_device_image = type { i8*, i8*, %struct.__tgt_offload_entry*, %struct.__tgt_offload_entry* }
%struct.__tgt_bin_desc = type { i32, %struct.__tgt_device_image*, %struct.__tgt_offload_entry*, %struct.__tgt_offload_entry* }

$.omp_offloading.descriptor_reg = comdat any

@.str = private unnamed_addr constant [27 x i8] c"\0A\0ANUMBER OF DEVICES: %d\0A\0A\0A\00", align 1
@.str.1 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@__omp_offloading_806_122265a_main_l13.region_id = weak constant i8 0
@.offload_sizes = private unnamed_addr constant [1 x i64] [i64 12]
@.offload_maptypes = private unnamed_addr constant [1 x i64] [i64 35]
@__omp_offloading_806_122265a_main_l17.region_id = weak constant i8 0
@.offload_sizes.2 = private unnamed_addr constant [1 x i64] [i64 12]
@.offload_maptypes.3 = private unnamed_addr constant [1 x i64] [i64 35]
@1 = private unnamed_addr constant %ident_t { i32 0, i32 322, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@.str.4 = private unnamed_addr constant [14 x i8] c"result:  %d \0A\00", align 1
@.omp_offloading.entry_name = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_122265a_main_l13\00"
@.omp_offloading.entry_module = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_122265a_main_l13 = weak constant %struct.__tgt_offload_entry { i8* @__omp_offloading_806_122265a_main_l13.region_id, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entry_name.5 = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_122265a_main_l17\00"
@.omp_offloading.entry_module.6 = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_122265a_main_l17 = weak constant %struct.__tgt_offload_entry { i8* @__omp_offloading_806_122265a_main_l17.region_id, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name.5, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module.6, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entries_begin = external constant %struct.__tgt_offload_entry
@.omp_offloading.entries_end = external constant %struct.__tgt_offload_entry
@.omp_offloading.img_start.x86_64-unknown-linux-gnu = external constant i8
@.omp_offloading.img_end.x86_64-unknown-linux-gnu = external constant i8
@.omp_offloading.img_start.nvptx64-nvidia-cuda = external constant i8
@.omp_offloading.img_end.nvptx64-nvidia-cuda = external constant i8
@.omp_offloading.device_images = internal unnamed_addr constant [2 x %struct.__tgt_device_image] [%struct.__tgt_device_image { i8* @.omp_offloading.img_start.x86_64-unknown-linux-gnu, i8* @.omp_offloading.img_end.x86_64-unknown-linux-gnu, %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }, %struct.__tgt_device_image { i8* @.omp_offloading.img_start.nvptx64-nvidia-cuda, i8* @.omp_offloading.img_end.nvptx64-nvidia-cuda, %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }], comdat($.omp_offloading.descriptor_reg), align 8
@.omp_offloading.descriptor = internal constant %struct.__tgt_bin_desc { i32 2, %struct.__tgt_device_image* getelementptr inbounds ([2 x %struct.__tgt_device_image], [2 x %struct.__tgt_device_image]* @.omp_offloading.device_images, i32 0, i32 0), %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }, comdat($.omp_offloading.descriptor_reg), align 8
@__dso_handle = external global i8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 0, void ()* @.omp_offloading.descriptor_reg, i8* bitcast (void ()* @.omp_offloading.descriptor_reg to i8*) }]

; Function Attrs: noinline norecurse uwtable
define i32 @main() #0 {
entry:
  %A = alloca [3 x i32], align 4
  call void @omp_set_num_threads(i32 2)
  %call = call i32 @omp_get_num_devices()
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str, i32 0, i32 0), i32 %call)
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 1, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, [3 x i32]*)* @.omp_outlined. to void (i32*, i32*, ...)*), [3 x i32]* %A)
  %arrayidx = getelementptr inbounds [3 x i32], [3 x i32]* %A, i64 0, i64 0
  %0 = load i32, i32* %arrayidx, align 4
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.4, i32 0, i32 0), i32 %0)
  ret i32 0
}

declare void @omp_set_num_threads(i32) #1

declare i32 @printf(i8*, ...) #1

declare i32 @omp_get_num_devices() #1

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., [3 x i32]* dereferenceable(12) %A) #2 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %A.addr = alloca [3 x i32]*, align 8
  %.offload_baseptrs = alloca [1 x i8*], align 8
  %.offload_ptrs = alloca [1 x i8*], align 8
  %.offload_baseptrs2 = alloca [1 x i8*], align 8
  %.offload_ptrs3 = alloca [1 x i8*], align 8
  store i32* %.global_tid., i32** %.global_tid..addr, align 8
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8
  store [3 x i32]* %A, [3 x i32]** %A.addr, align 8
  %0 = load [3 x i32]*, [3 x i32]** %A.addr, align 8
  %1 = load i32*, i32** %.global_tid..addr, align 8
  %2 = load i32, i32* %1, align 4
  %3 = call i32 @__kmpc_single(%ident_t* @0, i32 %2)
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %omp_if.then, label %omp_if.end

omp_if.then:                                      ; preds = %entry
  %arrayidx = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 0
  %5 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs, i32 0, i32 0
  %6 = bitcast i8** %5 to [3 x i32]**
  store [3 x i32]* %0, [3 x i32]** %6, align 8
  %7 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs, i32 0, i32 0
  %8 = bitcast i8** %7 to i32**
  store i32* %arrayidx, i32** %8, align 8
  %9 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs, i32 0, i32 0
  %10 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs, i32 0, i32 0
  %11 = call i32 @__tgt_target_nowait(i64 0, i8* @__omp_offloading_806_122265a_main_l13.region_id, i32 1, i8** %9, i8** %10, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_sizes, i32 0, i32 0), i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes, i32 0, i32 0), i8* null)
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %omp_offload.failed, label %omp_offload.cont

omp_offload.failed:                               ; preds = %omp_if.then
  call void @__omp_offloading_806_122265a_main_l13([3 x i32]* %0) #4
  br label %omp_offload.cont

omp_offload.cont:                                 ; preds = %omp_offload.failed, %omp_if.then
  %arrayidx1 = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 0
  %13 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs2, i32 0, i32 0
  %14 = bitcast i8** %13 to [3 x i32]**
  store [3 x i32]* %0, [3 x i32]** %14, align 8
  %15 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs3, i32 0, i32 0
  %16 = bitcast i8** %15 to i32**
  store i32* %arrayidx1, i32** %16, align 8
  %17 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs2, i32 0, i32 0
  %18 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs3, i32 0, i32 0
  %19 = call i32 @__tgt_target_nowait(i64 4, i8* @__omp_offloading_806_122265a_main_l17.region_id, i32 1, i8** %17, i8** %18, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_sizes.2, i32 0, i32 0), i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes.3, i32 0, i32 0), i8* null)
  %20 = icmp ne i32 %19, 0
  br i1 %20, label %omp_offload.failed4, label %omp_offload.cont5

omp_offload.failed4:                              ; preds = %omp_offload.cont
  call void @__omp_offloading_806_122265a_main_l17([3 x i32]* %0) #4
  br label %omp_offload.cont5

omp_offload.cont5:                                ; preds = %omp_offload.failed4, %omp_offload.cont
  call void @__kmpc_end_single(%ident_t* @0, i32 %2)
  br label %omp_if.end

omp_if.end:                                       ; preds = %omp_offload.cont5, %entry
  call void @__kmpc_barrier(%ident_t* @1, i32 %2)
  ret void
}

declare i32 @__kmpc_single(%ident_t*, i32)

declare void @__kmpc_end_single(%ident_t*, i32)

; Function Attrs: noinline nounwind uwtable
define internal void @__omp_offloading_806_122265a_main_l13([3 x i32]* dereferenceable(12) %A) #2 {
entry:
  %A.addr = alloca [3 x i32]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store [3 x i32]* %A, [3 x i32]** %A.addr, align 8
  %0 = load [3 x i32]*, [3 x i32]** %A.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc4, %entry
  %1 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %1, 9999
  br i1 %cmp, label %for.body, label %for.end6

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %2 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %2, 9999
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %arrayidx = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 0
  store i32 888, i32* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %3 = load i32, i32* %j, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc4

for.inc4:                                         ; preds = %for.end
  %4 = load i32, i32* %i, align 4
  %inc5 = add nsw i32 %4, 1
  store i32 %inc5, i32* %i, align 4
  br label %for.cond

for.end6:                                         ; preds = %for.cond
  ret void
}

declare i32 @__tgt_target_nowait(i64, i8*, i32, i8**, i8**, i64*, i64*, i8*)

; Function Attrs: noinline nounwind uwtable
define internal void @__omp_offloading_806_122265a_main_l17([3 x i32]* dereferenceable(12) %A) #2 {
entry:
  %A.addr = alloca [3 x i32]*, align 8
  store [3 x i32]* %A, [3 x i32]** %A.addr, align 8
  %0 = load [3 x i32]*, [3 x i32]** %A.addr, align 8
  %arrayidx = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 0
  %1 = load i32, i32* %arrayidx, align 4
  %add = add nsw i32 %1, 777
  store i32 %add, i32* %arrayidx, align 4
  ret void
}

declare void @__kmpc_barrier(%ident_t*, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: noinline uwtable
define internal void @.omp_offloading.descriptor_unreg(i8*) #3 section ".text.startup" comdat($.omp_offloading.descriptor_reg) {
entry:
  %.addr = alloca i8*, align 8
  store i8* %0, i8** %.addr, align 8
  %1 = call i32 @__tgt_unregister_lib(%struct.__tgt_bin_desc* @.omp_offloading.descriptor)
  ret void
}

declare i32 @__tgt_unregister_lib(%struct.__tgt_bin_desc*)

; Function Attrs: noinline uwtable
define linkonce hidden void @.omp_offloading.descriptor_reg() #3 section ".text.startup" comdat {
entry:
  %0 = call i32 @__tgt_register_lib(%struct.__tgt_bin_desc* @.omp_offloading.descriptor)
  %1 = call i32 @__cxa_atexit(void (i8*)* @.omp_offloading.descriptor_unreg, i8* bitcast (%struct.__tgt_bin_desc* @.omp_offloading.descriptor to i8*), i8* @__dso_handle) #4
  ret void
}

declare i32 @__tgt_register_lib(%struct.__tgt_bin_desc*)

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #4

attributes #0 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!omp_offload.info = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 0, i32 2054, i32 19015258, !"main", i32 13, i32 0}
!1 = !{i32 0, i32 2054, i32 19015258, !"main", i32 17, i32 1}
!2 = !{!"clang version 4.0.0 "}

; __CLANG_OFFLOAD_BUNDLE____END__ host-x86_64-unknown-linux-gnu
