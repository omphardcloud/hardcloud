
; __CLANG_OFFLOAD_BUNDLE____START__ openmp-nvptx64-nvidia-linux
; ModuleID = 'test.cpp'
source_filename = "test.cpp"
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-linux"

%struct.__openmp_nvptx_target_property_ty = type { i8, i32, i32 }
%struct.__openmp_nvptx_target_property_ty.0 = type { i8, i32, i32 }

@__omp_offloading_806_12246d8_main_l22_property = weak constant %struct.__openmp_nvptx_target_property_ty { i8 1, i32 0, i32 0 }, align 1
@__omp_offloading_806_12246d8_main_l35_property = weak constant %struct.__openmp_nvptx_target_property_ty.0 { i8 1, i32 0, i32 0 }, align 1

declare void @__kmpc_kernel_deinit(i16)

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() #0

; Function Attrs: noinline nounwind
define weak void @__omp_offloading_806_12246d8_main_l22([2 x i32]* dereferenceable(8) %A, i8* %scratchpad_ptr) #1 {
entry:
  %A.addr.i = alloca [2 x i32]*, align 8
  %i.i = alloca i32, align 4
  %j.i = alloca i32, align 4
  %A.addr = alloca [2 x i32]*, align 8
  %scratchpad_ptr.addr = alloca i8*, align 8
  store [2 x i32]* %A, [2 x i32]** %A.addr, align 8
  store i8* %scratchpad_ptr, i8** %scratchpad_ptr.addr, align 8
  %0 = load [2 x i32]*, [2 x i32]** %A.addr, align 8
  %1 = call i32 @__omp_kernel_initialization() #3
  %2 = icmp eq i32 %1, 1
  br i1 %2, label %.master.i, label %__omp_offloading_806_12246d8_main_l22_impl__.exit

.master.i:                                        ; preds = %entry
  store [2 x i32]* %0, [2 x i32]** %A.addr.i, align 8
  %3 = load [2 x i32]*, [2 x i32]** %A.addr.i, align 8
  store i32 0, i32* %i.i, align 4
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.end.i, %.master.i
  %4 = load i32, i32* %i.i, align 4
  %cmp.i = icmp slt i32 %4, 99
  br i1 %cmp.i, label %for.body.i, label %for.end6.i

for.body.i:                                       ; preds = %for.cond.i
  store i32 0, i32* %j.i, align 4
  br label %for.cond1.i

for.cond1.i:                                      ; preds = %for.body3.i, %for.body.i
  %5 = load i32, i32* %j.i, align 4
  %cmp2.i = icmp slt i32 %5, 99
  br i1 %cmp2.i, label %for.body3.i, label %for.end.i

for.body3.i:                                      ; preds = %for.cond1.i
  %arrayidx.i = getelementptr inbounds [2 x i32], [2 x i32]* %3, i64 0, i64 0
  store i32 10, i32* %arrayidx.i, align 4
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
  %arrayidx7.i = getelementptr inbounds [2 x i32], [2 x i32]* %3, i64 0, i64 1
  store i32 10, i32* %arrayidx7.i, align 4
  call void @__kmpc_kernel_deinit(i16 0) #3
  call void @llvm.nvvm.barrier0() #3
  br label %__omp_offloading_806_12246d8_main_l22_impl__.exit

__omp_offloading_806_12246d8_main_l22_impl__.exit: ; preds = %entry, %for.end6.i
  ret void
}

declare i1 @__kmpc_kernel_parallel(i8**, i16)

; Function Attrs: noinline nounwind
define weak void @__omp_offloading_806_12246d8_main_l35([2 x i32]* dereferenceable(8) %A, i8* %scratchpad_ptr) #1 {
entry:
  %A.addr.i = alloca [2 x i32]*, align 8
  %A.addr = alloca [2 x i32]*, align 8
  %scratchpad_ptr.addr = alloca i8*, align 8
  store [2 x i32]* %A, [2 x i32]** %A.addr, align 8
  store i8* %scratchpad_ptr, i8** %scratchpad_ptr.addr, align 8
  %0 = load [2 x i32]*, [2 x i32]** %A.addr, align 8
  %1 = call i32 @__omp_kernel_initialization.1() #3
  %2 = icmp eq i32 %1, 1
  br i1 %2, label %.master.i, label %__omp_offloading_806_12246d8_main_l35_impl__.exit

.master.i:                                        ; preds = %entry
  store [2 x i32]* %0, [2 x i32]** %A.addr.i, align 8
  %3 = load [2 x i32]*, [2 x i32]** %A.addr.i, align 8
  %arrayidx.i = getelementptr inbounds [2 x i32], [2 x i32]* %3, i64 0, i64 0
  %4 = load i32, i32* %arrayidx.i, align 4
  %add.i = add nsw i32 %4, 100
  store i32 %add.i, i32* %arrayidx.i, align 4
  %arrayidx1.i = getelementptr inbounds [2 x i32], [2 x i32]* %3, i64 0, i64 1
  %5 = load i32, i32* %arrayidx1.i, align 4
  %add2.i = add nsw i32 %5, 100
  store i32 %add2.i, i32* %arrayidx1.i, align 4
  call void @__kmpc_kernel_deinit(i16 0) #3
  call void @llvm.nvvm.barrier0() #3
  br label %__omp_offloading_806_12246d8_main_l35_impl__.exit

__omp_offloading_806_12246d8_main_l35_impl__.exit: ; preds = %entry, %.master.i
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
  br i1 %should_terminate.i, label %__omp_offloading_806_12246d8_main_l22_worker.exit, label %.select.workers.i

.select.workers.i:                                ; preds = %.await.work.i
  %8 = load i8, i8* %exec_status.i, align 1
  %is_active.i = icmp ne i8 %8, 0
  br i1 %is_active.i, label %.execute.parallel.i, label %.barrier.parallel.i

.execute.parallel.i:                              ; preds = %.select.workers.i
  br label %.barrier.parallel.i

.barrier.parallel.i:                              ; preds = %.execute.parallel.i, %.select.workers.i
  call void @llvm.nvvm.barrier0() #3
  br label %.await.work.i

__omp_offloading_806_12246d8_main_l22_worker.exit: ; preds = %.await.work.i
  br label %.exit

.exit:                                            ; preds = %__omp_offloading_806_12246d8_main_l22_worker.exit, %entry
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
  br i1 %should_terminate.i, label %__omp_offloading_806_12246d8_main_l35_worker.exit, label %.select.workers.i

.select.workers.i:                                ; preds = %.await.work.i
  %8 = load i8, i8* %exec_status.i, align 1
  %is_active.i = icmp ne i8 %8, 0
  br i1 %is_active.i, label %.execute.parallel.i, label %.barrier.parallel.i

.execute.parallel.i:                              ; preds = %.select.workers.i
  br label %.barrier.parallel.i

.barrier.parallel.i:                              ; preds = %.execute.parallel.i, %.select.workers.i
  call void @llvm.nvvm.barrier0() #3
  br label %.await.work.i

__omp_offloading_806_12246d8_main_l35_worker.exit: ; preds = %.await.work.i
  br label %.exit

.exit:                                            ; preds = %__omp_offloading_806_12246d8_main_l35_worker.exit, %entry
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

!0 = !{i32 0, i32 2054, i32 19023576, !"main", i32 35, i32 1}
!1 = !{i32 0, i32 2054, i32 19023576, !"main", i32 22, i32 0}
!2 = !{void ([2 x i32]*, i8*)* @__omp_offloading_806_12246d8_main_l22, !"kernel", i32 1}
!3 = !{void ([2 x i32]*, i8*)* @__omp_offloading_806_12246d8_main_l35, !"kernel", i32 1}
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

; __CLANG_OFFLOAD_BUNDLE____END__ openmp-nvptx64-nvidia-linux

; __CLANG_OFFLOAD_BUNDLE____START__ openmp-x86_64-unknown-linux-gnu
; ModuleID = 'test.cpp'
source_filename = "test.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__tgt_offload_entry = type { i8*, i8*, i8*, i64, i32, i32, i32 }

@.omp_offloading.entry_name = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_12246d8_main_l22\00"
@.omp_offloading.entry_module = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_12246d8_main_l22 = weak constant %struct.__tgt_offload_entry { i8* bitcast (void ([2 x i32]*)* @__omp_offloading_806_12246d8_main_l22 to i8*), i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entry_name.1 = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_12246d8_main_l35\00"
@.omp_offloading.entry_module.2 = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_12246d8_main_l35 = weak constant %struct.__tgt_offload_entry { i8* bitcast (void ([2 x i32]*)* @__omp_offloading_806_12246d8_main_l35 to i8*), i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module.2, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1

; Function Attrs: noinline nounwind uwtable
define weak void @__omp_offloading_806_12246d8_main_l22([2 x i32]* dereferenceable(8) %A) #0 {
entry:
  %A.addr = alloca [2 x i32]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store [2 x i32]* %A, [2 x i32]** %A.addr, align 8
  %0 = load [2 x i32]*, [2 x i32]** %A.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc4, %entry
  %1 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %1, 99
  br i1 %cmp, label %for.body, label %for.end6

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %2 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %2, 99
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %0, i64 0, i64 0
  store i32 10, i32* %arrayidx, align 4
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
  %arrayidx7 = getelementptr inbounds [2 x i32], [2 x i32]* %0, i64 0, i64 1
  store i32 10, i32* %arrayidx7, align 4
  ret void
}

; Function Attrs: noinline nounwind uwtable
define weak void @__omp_offloading_806_12246d8_main_l35([2 x i32]* dereferenceable(8) %A) #0 {
entry:
  %A.addr = alloca [2 x i32]*, align 8
  store [2 x i32]* %A, [2 x i32]** %A.addr, align 8
  %0 = load [2 x i32]*, [2 x i32]** %A.addr, align 8
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %0, i64 0, i64 0
  %1 = load i32, i32* %arrayidx, align 4
  %add = add nsw i32 %1, 100
  store i32 %add, i32* %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [2 x i32], [2 x i32]* %0, i64 0, i64 1
  %2 = load i32, i32* %arrayidx1, align 4
  %add2 = add nsw i32 %2, 100
  store i32 %add2, i32* %arrayidx1, align 4
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!omp_offload.info = !{!0, !1}
!llvm.module.flags = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 0, i32 2054, i32 19023576, !"main", i32 35, i32 1}
!1 = !{i32 0, i32 2054, i32 19023576, !"main", i32 22, i32 0}
!2 = !{i32 1, !"PIC Level", i32 2}
!3 = !{!"clang version 4.0.0 "}

; __CLANG_OFFLOAD_BUNDLE____END__ openmp-x86_64-unknown-linux-gnu

; __CLANG_OFFLOAD_BUNDLE____START__ host-x86_64-unknown-linux-gnu
; ModuleID = '/tmp/test-79252f.bc'
source_filename = "test.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%"class.std::ios_base::Init" = type { i8 }
%struct.__tgt_offload_entry = type { i8*, i8*, i8*, i64, i32, i32, i32 }
%struct.__tgt_device_image = type { i8*, i8*, %struct.__tgt_offload_entry*, %struct.__tgt_offload_entry* }
%struct.__tgt_bin_desc = type { i32, %struct.__tgt_device_image*, %struct.__tgt_offload_entry*, %struct.__tgt_offload_entry* }
%struct.anon = type { [2 x i32]* }
%struct.kmp_depend_info = type { i64, i64, i8 }
%struct.anon.0 = type { [2 x i32]* }
%struct.kmp_task_t_with_privates = type { %struct.kmp_task_t, %struct..kmp_privates.t }
%struct.kmp_task_t = type { i8*, i32 (i32, i8*)*, i32, %union.kmp_cmplrdata_t, %union.kmp_cmplrdata_t, i32, i32, i32 }
%union.kmp_cmplrdata_t = type { i32 (i32, i8*)* }
%struct..kmp_privates.t = type { [1 x i8*], [1 x i8*], [1 x i64] }
%struct.kmp_task_t_with_privates.1 = type { %struct.kmp_task_t, %struct..kmp_privates.t.2 }
%struct..kmp_privates.t.2 = type { [1 x i8*], [1 x i8*], [1 x i64] }

$__clang_call_terminate = comdat any

$.omp_offloading.descriptor_reg = comdat any

@_ZZ4mainE1A = private unnamed_addr constant [2 x i32] [i32 1, i32 2], align 4
@.str = private unnamed_addr constant [17 x i8] c"I am thread %d.\0A\00", align 1
@.str.1 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@__omp_offloading_806_12246d8_main_l22.region_id = weak constant i8 0
@.offload_sizes = private unnamed_addr constant [1 x i64] [i64 8]
@.offload_maptypes = private unnamed_addr constant [1 x i64] [i64 35]
@.offload_maptypes.3 = private unnamed_addr constant [1 x i64] [i64 35]
@__omp_offloading_806_12246d8_main_l35.region_id = weak constant i8 0
@.offload_sizes.4 = private unnamed_addr constant [1 x i64] [i64 8]
@.offload_maptypes.5 = private unnamed_addr constant [1 x i64] [i64 35]
@.offload_maptypes.7 = private unnamed_addr constant [1 x i64] [i64 35]
@.str.10 = private unnamed_addr constant [25 x i8] c"\0A\0ANumber of threads %d\0A\0A\00", align 1
@1 = private unnamed_addr constant %ident_t { i32 0, i32 322, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@.str.11 = private unnamed_addr constant [16 x i8] c"result:  %d %d\0A\00", align 1
@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@G = global i32 10, align 4
@.omp_offloading.entry_name = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_12246d8_main_l22\00"
@.omp_offloading.entry_module = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_12246d8_main_l22 = weak constant %struct.__tgt_offload_entry { i8* @__omp_offloading_806_12246d8_main_l22.region_id, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entry_name.12 = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_12246d8_main_l35\00"
@.omp_offloading.entry_module.13 = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_12246d8_main_l35 = weak constant %struct.__tgt_offload_entry { i8* @__omp_offloading_806_12246d8_main_l35.region_id, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name.12, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module.13, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entries_begin = external constant %struct.__tgt_offload_entry
@.omp_offloading.entries_end = external constant %struct.__tgt_offload_entry
@.omp_offloading.img_start.nvptx64-nvidia-linux = external constant i8
@.omp_offloading.img_end.nvptx64-nvidia-linux = external constant i8
@.omp_offloading.img_start.x86_64-unknown-linux-gnu = external constant i8
@.omp_offloading.img_end.x86_64-unknown-linux-gnu = external constant i8
@.omp_offloading.device_images = internal unnamed_addr constant [2 x %struct.__tgt_device_image] [%struct.__tgt_device_image { i8* @.omp_offloading.img_start.nvptx64-nvidia-linux, i8* @.omp_offloading.img_end.nvptx64-nvidia-linux, %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }, %struct.__tgt_device_image { i8* @.omp_offloading.img_start.x86_64-unknown-linux-gnu, i8* @.omp_offloading.img_end.x86_64-unknown-linux-gnu, %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }], comdat($.omp_offloading.descriptor_reg), align 8
@.omp_offloading.descriptor = internal constant %struct.__tgt_bin_desc { i32 2, %struct.__tgt_device_image* getelementptr inbounds ([2 x %struct.__tgt_device_image], [2 x %struct.__tgt_device_image]* @.omp_offloading.device_images, i32 0, i32 0), %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }, comdat($.omp_offloading.descriptor_reg), align 8
@llvm.global_ctors = appending global [2 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_test.cpp, i8* null }, { i32, void ()*, i8* } { i32 0, void ()* @.omp_offloading.descriptor_reg, i8* bitcast (void ()* @.omp_offloading.descriptor_reg to i8*) }]

; Function Attrs: noinline norecurse uwtable
define i32 @main() #0 {
entry:
  %A = alloca [2 x i32], align 4
  %L = alloca i32, align 4
  %0 = bitcast [2 x i32]* %A to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* bitcast ([2 x i32]* @_ZZ4mainE1A to i8*), i64 8, i32 4, i1 false)
  store i32 11, i32* %L, align 4
  call void @omp_set_num_threads(i32 4)
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 1, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, [2 x i32]*)* @.omp_outlined. to void (i32*, i32*, ...)*), [2 x i32]* %A)
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %A, i64 0, i64 0
  %1 = load i32, i32* %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [2 x i32], [2 x i32]* %A, i64 0, i64 1
  %2 = load i32, i32* %arrayidx1, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.11, i32 0, i32 0), i32 %1, i32 %2)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

declare void @omp_set_num_threads(i32) #2

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., [2 x i32]* dereferenceable(8) %A) #3 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %A.addr = alloca [2 x i32]*, align 8
  %0 = call i32 @__kmpc_global_thread_num(%ident_t* @0)
  %.offload_baseptrs = alloca [1 x i8*], align 8
  %.offload_ptrs = alloca [1 x i8*], align 8
  %agg.captured = alloca %struct.anon, align 8
  %.dep.arr.addr = alloca [1 x %struct.kmp_depend_info], align 8
  %.offload_baseptrs6 = alloca [1 x i8*], align 8
  %.offload_ptrs7 = alloca [1 x i8*], align 8
  %agg.captured8 = alloca %struct.anon.0, align 8
  %.dep.arr.addr9 = alloca [1 x %struct.kmp_depend_info], align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store i32* %.global_tid., i32** %.global_tid..addr, align 8
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8
  store [2 x i32]* %A, [2 x i32]** %A.addr, align 8
  %1 = load [2 x i32]*, [2 x i32]** %A.addr, align 8
  %call = invoke i32 @omp_get_thread_num()
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  %call2 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str, i32 0, i32 0), i32 %call)
          to label %invoke.cont1 unwind label %terminate.lpad

invoke.cont1:                                     ; preds = %invoke.cont
  %2 = call i32 @__kmpc_single(%ident_t* @0, i32 %0)
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %omp_if.then, label %omp_if.end

omp_if.then:                                      ; preds = %invoke.cont1
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 0
  %4 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs, i32 0, i32 0
  %5 = bitcast i8** %4 to [2 x i32]**
  store [2 x i32]* %1, [2 x i32]** %5, align 8
  %6 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs, i32 0, i32 0
  %7 = bitcast i8** %6 to i32**
  store i32* %arrayidx, i32** %7, align 8
  %8 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs, i32 0, i32 0
  %9 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs, i32 0, i32 0
  %10 = getelementptr inbounds %struct.anon, %struct.anon* %agg.captured, i32 0, i32 0
  store [2 x i32]* %1, [2 x i32]** %10, align 8
  %11 = call i8* @__kmpc_omp_target_task_alloc(%ident_t* @0, i32 %0, i32 1, i64 80, i64 8, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates*)* @.omp_task_entry. to i32 (i32, i8*)*), i64 0)
  %12 = bitcast i8* %11 to %struct.kmp_task_t_with_privates*
  %13 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %12, i32 0, i32 0
  %14 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %13, i32 0, i32 0
  %15 = load i8*, i8** %14, align 8
  %16 = bitcast %struct.anon* %agg.captured to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %15, i8* %16, i64 8, i32 8, i1 false)
  %17 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %12, i32 0, i32 1
  %18 = bitcast i8* %15 to %struct.anon*
  %19 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %17, i32 0, i32 0
  %20 = bitcast [1 x i8*]* %19 to i8*
  %21 = bitcast i8** %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %20, i8* %21, i64 8, i32 8, i1 false)
  %22 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %17, i32 0, i32 1
  %23 = bitcast [1 x i8*]* %22 to i8*
  %24 = bitcast i8** %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %23, i8* %24, i64 8, i32 8, i1 false)
  %25 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %17, i32 0, i32 2
  %26 = bitcast [1 x i64]* %25 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %26, i8* bitcast ([1 x i64]* @.offload_sizes to i8*), i64 8, i32 8, i1 false)
  %arrayidx3 = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 0
  %arrayidx4 = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 1
  %27 = getelementptr i32, i32* %arrayidx4, i32 1
  %28 = ptrtoint i32* %arrayidx3 to i64
  %29 = ptrtoint i32* %27 to i64
  %30 = sub nuw i64 %29, %28
  %31 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr, i64 0, i64 0
  %32 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %31, i32 0, i32 0
  %33 = ptrtoint i32* %arrayidx3 to i64
  store i64 %33, i64* %32, align 8
  %34 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %31, i32 0, i32 1
  store i64 %30, i64* %34, align 8
  %35 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %31, i32 0, i32 2
  store i8 3, i8* %35, align 8
  %36 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr, i32 0, i32 0
  %37 = bitcast %struct.kmp_depend_info* %36 to i8*
  %38 = call i32 @__kmpc_omp_task_with_deps(%ident_t* @0, i32 %0, i8* %11, i32 1, i8* %37, i32 0, i8* null)
  %arrayidx5 = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 0
  %39 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs6, i32 0, i32 0
  %40 = bitcast i8** %39 to [2 x i32]**
  store [2 x i32]* %1, [2 x i32]** %40, align 8
  %41 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs7, i32 0, i32 0
  %42 = bitcast i8** %41 to i32**
  store i32* %arrayidx5, i32** %42, align 8
  %43 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs6, i32 0, i32 0
  %44 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs7, i32 0, i32 0
  %45 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %agg.captured8, i32 0, i32 0
  store [2 x i32]* %1, [2 x i32]** %45, align 8
  %46 = call i8* @__kmpc_omp_target_task_alloc(%ident_t* @0, i32 %0, i32 1, i64 80, i64 8, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates.1*)* @.omp_task_entry..9 to i32 (i32, i8*)*), i64 0)
  %47 = bitcast i8* %46 to %struct.kmp_task_t_with_privates.1*
  %48 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %47, i32 0, i32 0
  %49 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %48, i32 0, i32 0
  %50 = load i8*, i8** %49, align 8
  %51 = bitcast %struct.anon.0* %agg.captured8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %50, i8* %51, i64 8, i32 8, i1 false)
  %52 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %47, i32 0, i32 1
  %53 = bitcast i8* %50 to %struct.anon.0*
  %54 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %52, i32 0, i32 0
  %55 = bitcast [1 x i8*]* %54 to i8*
  %56 = bitcast i8** %43 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %55, i8* %56, i64 8, i32 8, i1 false)
  %57 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %52, i32 0, i32 1
  %58 = bitcast [1 x i8*]* %57 to i8*
  %59 = bitcast i8** %44 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %58, i8* %59, i64 8, i32 8, i1 false)
  %60 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %52, i32 0, i32 2
  %61 = bitcast [1 x i64]* %60 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %61, i8* bitcast ([1 x i64]* @.offload_sizes.4 to i8*), i64 8, i32 8, i1 false)
  %arrayidx10 = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 0
  %arrayidx11 = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 1
  %62 = getelementptr i32, i32* %arrayidx11, i32 1
  %63 = ptrtoint i32* %arrayidx10 to i64
  %64 = ptrtoint i32* %62 to i64
  %65 = sub nuw i64 %64, %63
  %66 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr9, i64 0, i64 0
  %67 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %66, i32 0, i32 0
  %68 = ptrtoint i32* %arrayidx10 to i64
  store i64 %68, i64* %67, align 8
  %69 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %66, i32 0, i32 1
  store i64 %65, i64* %69, align 8
  %70 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %66, i32 0, i32 2
  store i8 1, i8* %70, align 8
  %71 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr9, i32 0, i32 0
  %72 = bitcast %struct.kmp_depend_info* %71 to i8*
  %73 = call i32 @__kmpc_omp_task_with_deps(%ident_t* @0, i32 %0, i8* %46, i32 1, i8* %72, i32 0, i8* null)
  %call13 = invoke i32 @omp_get_num_threads()
          to label %invoke.cont12 unwind label %lpad

invoke.cont12:                                    ; preds = %omp_if.then
  %call15 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.10, i32 0, i32 0), i32 %call13)
          to label %invoke.cont14 unwind label %lpad

invoke.cont14:                                    ; preds = %invoke.cont12
  call void @__kmpc_end_single(%ident_t* @0, i32 %0)
  br label %omp_if.end

lpad:                                             ; preds = %invoke.cont12, %omp_if.then
  %74 = landingpad { i8*, i32 }
          catch i8* null
  %75 = extractvalue { i8*, i32 } %74, 0
  store i8* %75, i8** %exn.slot, align 8
  %76 = extractvalue { i8*, i32 } %74, 1
  store i32 %76, i32* %ehselector.slot, align 4
  call void @__kmpc_end_single(%ident_t* @0, i32 %0)
  br label %terminate.handler

omp_if.end:                                       ; preds = %invoke.cont14, %invoke.cont1
  call void @__kmpc_barrier(%ident_t* @1, i32 %0)
  ret void

terminate.lpad:                                   ; preds = %invoke.cont, %entry
  %77 = landingpad { i8*, i32 }
          catch i8* null
  %78 = extractvalue { i8*, i32 } %77, 0
  call void @__clang_call_terminate(i8* %78) #8
  unreachable

terminate.handler:                                ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  call void @__clang_call_terminate(i8* %exn) #8
  unreachable
}

declare i32 @printf(i8*, ...) #2

declare i32 @omp_get_thread_num() #2

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #4 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #7
  call void @_ZSt9terminatev() #8
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

declare i32 @__kmpc_global_thread_num(%ident_t*)

declare i32 @__kmpc_single(%ident_t*, i32)

declare void @__kmpc_end_single(%ident_t*, i32)

; Function Attrs: noinline nounwind uwtable
define internal void @__omp_offloading_806_12246d8_main_l22([2 x i32]* dereferenceable(8) %A) #3 {
entry:
  %A.addr = alloca [2 x i32]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store [2 x i32]* %A, [2 x i32]** %A.addr, align 8
  %0 = load [2 x i32]*, [2 x i32]** %A.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc4, %entry
  %1 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %1, 99
  br i1 %cmp, label %for.body, label %for.end6

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %2 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %2, 99
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %0, i64 0, i64 0
  store i32 10, i32* %arrayidx, align 4
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
  %arrayidx7 = getelementptr inbounds [2 x i32], [2 x i32]* %0, i64 0, i64 1
  store i32 10, i32* %arrayidx7, align 4
  ret void
}

declare i32 @__tgt_target_nowait(i64, i8*, i32, i8**, i8**, i64*, i64*, i8*)

; Function Attrs: alwaysinline uwtable
define internal void @.omp_task_privates_map.(%struct..kmp_privates.t* noalias, [1 x i8*]** noalias, [1 x i8*]** noalias, [1 x i64]** noalias) #5 {
entry:
  %.addr = alloca %struct..kmp_privates.t*, align 8
  %.addr1 = alloca [1 x i8*]**, align 8
  %.addr2 = alloca [1 x i8*]**, align 8
  %.addr3 = alloca [1 x i64]**, align 8
  store %struct..kmp_privates.t* %0, %struct..kmp_privates.t** %.addr, align 8
  store [1 x i8*]** %1, [1 x i8*]*** %.addr1, align 8
  store [1 x i8*]** %2, [1 x i8*]*** %.addr2, align 8
  store [1 x i64]** %3, [1 x i64]*** %.addr3, align 8
  %4 = load %struct..kmp_privates.t*, %struct..kmp_privates.t** %.addr, align 8
  %5 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %4, i32 0, i32 0
  %6 = load [1 x i8*]**, [1 x i8*]*** %.addr1, align 8
  store [1 x i8*]* %5, [1 x i8*]** %6, align 8
  %7 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %4, i32 0, i32 1
  %8 = load [1 x i8*]**, [1 x i8*]*** %.addr2, align 8
  store [1 x i8*]* %7, [1 x i8*]** %8, align 8
  %9 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %4, i32 0, i32 2
  %10 = load [1 x i64]**, [1 x i64]*** %.addr3, align 8
  store [1 x i64]* %9, [1 x i64]** %10, align 8
  ret void
}

; Function Attrs: noinline uwtable
define internal i32 @.omp_task_entry.(i32, %struct.kmp_task_t_with_privates* noalias) #6 {
entry:
  %.global_tid..addr.i = alloca i32, align 4
  %.part_id..addr.i = alloca i32*, align 8
  %.privates..addr.i = alloca i8*, align 8
  %.copy_fn..addr.i = alloca void (i8*, ...)*, align 8
  %.task_t..addr.i = alloca i8*, align 8
  %__context.addr.i = alloca %struct.anon*, align 8
  %2 = alloca [1 x i8*]*, align 8
  %3 = alloca [1 x i8*]*, align 8
  %4 = alloca [1 x i64]*, align 8
  %.addr = alloca i32, align 4
  %.addr1 = alloca %struct.kmp_task_t_with_privates*, align 8
  store i32 %0, i32* %.addr, align 4
  store %struct.kmp_task_t_with_privates* %1, %struct.kmp_task_t_with_privates** %.addr1, align 8
  %5 = load i32, i32* %.addr, align 4
  %6 = load %struct.kmp_task_t_with_privates*, %struct.kmp_task_t_with_privates** %.addr1, align 8
  %7 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %6, i32 0, i32 0
  %8 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %7, i32 0, i32 2
  %9 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %7, i32 0, i32 0
  %10 = load i8*, i8** %9, align 8
  %11 = bitcast i8* %10 to %struct.anon*
  %12 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %6, i32 0, i32 1
  %13 = bitcast %struct..kmp_privates.t* %12 to i8*
  %14 = bitcast %struct.kmp_task_t_with_privates* %6 to i8*
  store i32 %5, i32* %.global_tid..addr.i, align 4
  store i32* %8, i32** %.part_id..addr.i, align 8
  store i8* %13, i8** %.privates..addr.i, align 8
  store void (i8*, ...)* bitcast (void (%struct..kmp_privates.t*, [1 x i8*]**, [1 x i8*]**, [1 x i64]**)* @.omp_task_privates_map. to void (i8*, ...)*), void (i8*, ...)** %.copy_fn..addr.i, align 8
  store i8* %14, i8** %.task_t..addr.i, align 8
  store %struct.anon* %11, %struct.anon** %__context.addr.i, align 8
  %15 = load %struct.anon*, %struct.anon** %__context.addr.i, align 8
  %16 = load void (i8*, ...)*, void (i8*, ...)** %.copy_fn..addr.i, align 8
  %17 = load i8*, i8** %.privates..addr.i, align 8
  call void (i8*, ...) %16(i8* %17, [1 x i8*]** %2, [1 x i8*]** %3, [1 x i64]** %4) #7
  %18 = getelementptr inbounds %struct.anon, %struct.anon* %15, i32 0, i32 0
  %ref.i = load [2 x i32]*, [2 x i32]** %18, align 8
  %19 = load [1 x i8*]*, [1 x i8*]** %2, align 8
  %20 = load [1 x i8*]*, [1 x i8*]** %3, align 8
  %21 = load [1 x i64]*, [1 x i64]** %4, align 8
  %22 = getelementptr inbounds [1 x i8*], [1 x i8*]* %19, i64 0, i64 0
  %23 = getelementptr inbounds [1 x i8*], [1 x i8*]* %20, i64 0, i64 0
  %24 = getelementptr inbounds [1 x i64], [1 x i64]* %21, i64 0, i64 0
  %25 = call i32 @__tgt_target_nowait(i64 0, i8* @__omp_offloading_806_12246d8_main_l22.region_id, i32 1, i8** %22, i8** %23, i64* %24, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes.3, i32 0, i32 0), i8* %14) #7
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %omp_offload.failed.i, label %.omp_outlined..2.exit

omp_offload.failed.i:                             ; preds = %entry
  %arrayidx.i = getelementptr inbounds [2 x i32], [2 x i32]* %ref.i, i64 0, i64 0
  call void @__omp_offloading_806_12246d8_main_l22([2 x i32]* %ref.i) #7
  br label %.omp_outlined..2.exit

.omp_outlined..2.exit:                            ; preds = %entry, %omp_offload.failed.i
  ret i32 0
}

declare i8* @__kmpc_omp_target_task_alloc(%ident_t*, i32, i32, i64, i64, i32 (i32, i8*)*, i64)

declare i32 @__kmpc_omp_task_with_deps(%ident_t*, i32, i8*, i32, i8*, i32, i8*)

; Function Attrs: noinline nounwind uwtable
define internal void @__omp_offloading_806_12246d8_main_l35([2 x i32]* dereferenceable(8) %A) #3 {
entry:
  %A.addr = alloca [2 x i32]*, align 8
  store [2 x i32]* %A, [2 x i32]** %A.addr, align 8
  %0 = load [2 x i32]*, [2 x i32]** %A.addr, align 8
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %0, i64 0, i64 0
  %1 = load i32, i32* %arrayidx, align 4
  %add = add nsw i32 %1, 100
  store i32 %add, i32* %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [2 x i32], [2 x i32]* %0, i64 0, i64 1
  %2 = load i32, i32* %arrayidx1, align 4
  %add2 = add nsw i32 %2, 100
  store i32 %add2, i32* %arrayidx1, align 4
  ret void
}

; Function Attrs: alwaysinline uwtable
define internal void @.omp_task_privates_map..8(%struct..kmp_privates.t.2* noalias, [1 x i8*]** noalias, [1 x i8*]** noalias, [1 x i64]** noalias) #5 {
entry:
  %.addr = alloca %struct..kmp_privates.t.2*, align 8
  %.addr1 = alloca [1 x i8*]**, align 8
  %.addr2 = alloca [1 x i8*]**, align 8
  %.addr3 = alloca [1 x i64]**, align 8
  store %struct..kmp_privates.t.2* %0, %struct..kmp_privates.t.2** %.addr, align 8
  store [1 x i8*]** %1, [1 x i8*]*** %.addr1, align 8
  store [1 x i8*]** %2, [1 x i8*]*** %.addr2, align 8
  store [1 x i64]** %3, [1 x i64]*** %.addr3, align 8
  %4 = load %struct..kmp_privates.t.2*, %struct..kmp_privates.t.2** %.addr, align 8
  %5 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %4, i32 0, i32 0
  %6 = load [1 x i8*]**, [1 x i8*]*** %.addr1, align 8
  store [1 x i8*]* %5, [1 x i8*]** %6, align 8
  %7 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %4, i32 0, i32 1
  %8 = load [1 x i8*]**, [1 x i8*]*** %.addr2, align 8
  store [1 x i8*]* %7, [1 x i8*]** %8, align 8
  %9 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %4, i32 0, i32 2
  %10 = load [1 x i64]**, [1 x i64]*** %.addr3, align 8
  store [1 x i64]* %9, [1 x i64]** %10, align 8
  ret void
}

; Function Attrs: noinline uwtable
define internal i32 @.omp_task_entry..9(i32, %struct.kmp_task_t_with_privates.1* noalias) #6 {
entry:
  %.global_tid..addr.i = alloca i32, align 4
  %.part_id..addr.i = alloca i32*, align 8
  %.privates..addr.i = alloca i8*, align 8
  %.copy_fn..addr.i = alloca void (i8*, ...)*, align 8
  %.task_t..addr.i = alloca i8*, align 8
  %__context.addr.i = alloca %struct.anon.0*, align 8
  %2 = alloca [1 x i8*]*, align 8
  %3 = alloca [1 x i8*]*, align 8
  %4 = alloca [1 x i64]*, align 8
  %.addr = alloca i32, align 4
  %.addr1 = alloca %struct.kmp_task_t_with_privates.1*, align 8
  store i32 %0, i32* %.addr, align 4
  store %struct.kmp_task_t_with_privates.1* %1, %struct.kmp_task_t_with_privates.1** %.addr1, align 8
  %5 = load i32, i32* %.addr, align 4
  %6 = load %struct.kmp_task_t_with_privates.1*, %struct.kmp_task_t_with_privates.1** %.addr1, align 8
  %7 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %6, i32 0, i32 0
  %8 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %7, i32 0, i32 2
  %9 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %7, i32 0, i32 0
  %10 = load i8*, i8** %9, align 8
  %11 = bitcast i8* %10 to %struct.anon.0*
  %12 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %6, i32 0, i32 1
  %13 = bitcast %struct..kmp_privates.t.2* %12 to i8*
  %14 = bitcast %struct.kmp_task_t_with_privates.1* %6 to i8*
  store i32 %5, i32* %.global_tid..addr.i, align 4
  store i32* %8, i32** %.part_id..addr.i, align 8
  store i8* %13, i8** %.privates..addr.i, align 8
  store void (i8*, ...)* bitcast (void (%struct..kmp_privates.t.2*, [1 x i8*]**, [1 x i8*]**, [1 x i64]**)* @.omp_task_privates_map..8 to void (i8*, ...)*), void (i8*, ...)** %.copy_fn..addr.i, align 8
  store i8* %14, i8** %.task_t..addr.i, align 8
  store %struct.anon.0* %11, %struct.anon.0** %__context.addr.i, align 8
  %15 = load %struct.anon.0*, %struct.anon.0** %__context.addr.i, align 8
  %16 = load void (i8*, ...)*, void (i8*, ...)** %.copy_fn..addr.i, align 8
  %17 = load i8*, i8** %.privates..addr.i, align 8
  call void (i8*, ...) %16(i8* %17, [1 x i8*]** %2, [1 x i8*]** %3, [1 x i64]** %4) #7
  %18 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %15, i32 0, i32 0
  %ref.i = load [2 x i32]*, [2 x i32]** %18, align 8
  %19 = load [1 x i8*]*, [1 x i8*]** %2, align 8
  %20 = load [1 x i8*]*, [1 x i8*]** %3, align 8
  %21 = load [1 x i64]*, [1 x i64]** %4, align 8
  %22 = getelementptr inbounds [1 x i8*], [1 x i8*]* %19, i64 0, i64 0
  %23 = getelementptr inbounds [1 x i8*], [1 x i8*]* %20, i64 0, i64 0
  %24 = getelementptr inbounds [1 x i64], [1 x i64]* %21, i64 0, i64 0
  %25 = call i32 @__tgt_target_nowait(i64 0, i8* @__omp_offloading_806_12246d8_main_l35.region_id, i32 1, i8** %22, i8** %23, i64* %24, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes.7, i32 0, i32 0), i8* %14) #7
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %omp_offload.failed.i, label %.omp_outlined..6.exit

omp_offload.failed.i:                             ; preds = %entry
  %arrayidx.i = getelementptr inbounds [2 x i32], [2 x i32]* %ref.i, i64 0, i64 0
  call void @__omp_offloading_806_12246d8_main_l35([2 x i32]* %ref.i) #7
  br label %.omp_outlined..6.exit

.omp_outlined..6.exit:                            ; preds = %entry, %omp_offload.failed.i
  ret i32 0
}

declare i32 @omp_get_num_threads() #2

declare void @__kmpc_barrier(%ident_t*, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #6 section ".text.startup" {
entry:
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #7
  ret void
}

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) unnamed_addr #2

declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) unnamed_addr #2

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #7

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #6 section ".text.startup" {
entry:
  call void @__cxx_global_var_init()
  ret void
}

; Function Attrs: noinline uwtable
define internal void @.omp_offloading.descriptor_unreg(i8*) #6 section ".text.startup" comdat($.omp_offloading.descriptor_reg) {
entry:
  %.addr = alloca i8*, align 8
  store i8* %0, i8** %.addr, align 8
  %1 = call i32 @__tgt_unregister_lib(%struct.__tgt_bin_desc* @.omp_offloading.descriptor)
  ret void
}

declare i32 @__tgt_unregister_lib(%struct.__tgt_bin_desc*)

; Function Attrs: noinline uwtable
define linkonce hidden void @.omp_offloading.descriptor_reg() #6 section ".text.startup" comdat {
entry:
  %0 = call i32 @__tgt_register_lib(%struct.__tgt_bin_desc* @.omp_offloading.descriptor)
  %1 = call i32 @__cxa_atexit(void (i8*)* @.omp_offloading.descriptor_unreg, i8* bitcast (%struct.__tgt_bin_desc* @.omp_offloading.descriptor to i8*), i8* @__dso_handle) #7
  ret void
}

declare i32 @__tgt_register_lib(%struct.__tgt_bin_desc*)

attributes #0 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline noreturn nounwind }
attributes #5 = { alwaysinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind }
attributes #8 = { noreturn nounwind }

!omp_offload.info = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 0, i32 2054, i32 19023576, !"main", i32 35, i32 1}
!1 = !{i32 0, i32 2054, i32 19023576, !"main", i32 22, i32 0}
!2 = !{!"clang version 4.0.0 "}

; __CLANG_OFFLOAD_BUNDLE____END__ host-x86_64-unknown-linux-gnu
