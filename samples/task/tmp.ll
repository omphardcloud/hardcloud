
; __CLANG_OFFLOAD_BUNDLE____START__ openmp-x86_64-unknown-linux-gnu
; ModuleID = 'tmp.cpp'
source_filename = "tmp.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__tgt_offload_entry = type { i8*, i8*, i8*, i64, i32, i32, i32 }

@.omp_offloading.entry_name = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_1222644_main_l13\00"
@.omp_offloading.entry_module = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_1222644_main_l13 = weak constant %struct.__tgt_offload_entry { i8* bitcast (void (i32*)* @__omp_offloading_806_1222644_main_l13 to i8*), i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entry_name.1 = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_1222644_main_l17\00"
@.omp_offloading.entry_module.2 = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_1222644_main_l17 = weak constant %struct.__tgt_offload_entry { i8* bitcast (void (i32*)* @__omp_offloading_806_1222644_main_l17 to i8*), i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module.2, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1

; Function Attrs: noinline nounwind uwtable
define weak void @__omp_offloading_806_1222644_main_l13(i32* dereferenceable(4) %A) #0 {
entry:
  %A.addr = alloca i32*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32* %A, i32** %A.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
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
  store i32 888, i32* %0, align 4
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
define weak void @__omp_offloading_806_1222644_main_l17(i32* dereferenceable(4) %A) #0 {
entry:
  %A.addr = alloca i32*, align 8
  store i32* %A, i32** %A.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  %1 = load i32, i32* %0, align 4
  %add = add nsw i32 %1, 777
  store i32 %add, i32* %0, align 4
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!omp_offload.info = !{!0, !1}
!llvm.module.flags = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 0, i32 2054, i32 19015236, !"main", i32 13, i32 0}
!1 = !{i32 0, i32 2054, i32 19015236, !"main", i32 17, i32 1}
!2 = !{i32 1, !"PIC Level", i32 2}
!3 = !{!"clang version 4.0.0 "}

; __CLANG_OFFLOAD_BUNDLE____END__ openmp-x86_64-unknown-linux-gnu

; __CLANG_OFFLOAD_BUNDLE____START__ openmp-nvptx64-nvidia-cuda
; ModuleID = 'tmp.cpp'
source_filename = "tmp.cpp"
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

%struct.__openmp_nvptx_target_property_ty = type { i8, i32, i32 }
%struct.__openmp_nvptx_target_property_ty.0 = type { i8, i32, i32 }

@__omp_offloading_806_1222644_main_l13_property = weak constant %struct.__openmp_nvptx_target_property_ty { i8 1, i32 0, i32 0 }, align 1
@__omp_offloading_806_1222644_main_l17_property = weak constant %struct.__openmp_nvptx_target_property_ty.0 { i8 1, i32 0, i32 0 }, align 1

declare void @__kmpc_kernel_deinit(i16)

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() #0

; Function Attrs: noinline nounwind
define weak void @__omp_offloading_806_1222644_main_l13(i32* dereferenceable(4) %A, i8* %scratchpad_ptr) #1 {
entry:
  %A.addr.i = alloca i32*, align 8
  %i.i = alloca i32, align 4
  %j.i = alloca i32, align 4
  %A.addr = alloca i32*, align 8
  %scratchpad_ptr.addr = alloca i8*, align 8
  store i32* %A, i32** %A.addr, align 8
  store i8* %scratchpad_ptr, i8** %scratchpad_ptr.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  %1 = call i32 @__omp_kernel_initialization() #3
  %2 = icmp eq i32 %1, 1
  br i1 %2, label %.master.i, label %__omp_offloading_806_1222644_main_l13_impl__.exit

.master.i:                                        ; preds = %entry
  store i32* %0, i32** %A.addr.i, align 8
  %3 = load i32*, i32** %A.addr.i, align 8
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
  store i32 888, i32* %3, align 4
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
  br label %__omp_offloading_806_1222644_main_l13_impl__.exit

__omp_offloading_806_1222644_main_l13_impl__.exit: ; preds = %entry, %for.end6.i
  ret void
}

declare i1 @__kmpc_kernel_parallel(i8**, i16)

; Function Attrs: noinline nounwind
define weak void @__omp_offloading_806_1222644_main_l17(i32* dereferenceable(4) %A, i8* %scratchpad_ptr) #1 {
entry:
  %A.addr.i = alloca i32*, align 8
  %A.addr = alloca i32*, align 8
  %scratchpad_ptr.addr = alloca i8*, align 8
  store i32* %A, i32** %A.addr, align 8
  store i8* %scratchpad_ptr, i8** %scratchpad_ptr.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  %1 = call i32 @__omp_kernel_initialization.1() #3
  %2 = icmp eq i32 %1, 1
  br i1 %2, label %.master.i, label %__omp_offloading_806_1222644_main_l17_impl__.exit

.master.i:                                        ; preds = %entry
  store i32* %0, i32** %A.addr.i, align 8
  %3 = load i32*, i32** %A.addr.i, align 8
  %4 = load i32, i32* %3, align 4
  %add.i = add nsw i32 %4, 777
  store i32 %add.i, i32* %3, align 4
  call void @__kmpc_kernel_deinit(i16 0) #3
  call void @llvm.nvvm.barrier0() #3
  br label %__omp_offloading_806_1222644_main_l17_impl__.exit

__omp_offloading_806_1222644_main_l17_impl__.exit: ; preds = %entry, %.master.i
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
  br i1 %should_terminate.i, label %__omp_offloading_806_1222644_main_l13_worker.exit, label %.select.workers.i

.select.workers.i:                                ; preds = %.await.work.i
  %8 = load i8, i8* %exec_status.i, align 1
  %is_active.i = icmp ne i8 %8, 0
  br i1 %is_active.i, label %.execute.parallel.i, label %.barrier.parallel.i

.execute.parallel.i:                              ; preds = %.select.workers.i
  br label %.barrier.parallel.i

.barrier.parallel.i:                              ; preds = %.execute.parallel.i, %.select.workers.i
  call void @llvm.nvvm.barrier0() #3
  br label %.await.work.i

__omp_offloading_806_1222644_main_l13_worker.exit: ; preds = %.await.work.i
  br label %.exit

.exit:                                            ; preds = %__omp_offloading_806_1222644_main_l13_worker.exit, %entry
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
  br i1 %should_terminate.i, label %__omp_offloading_806_1222644_main_l17_worker.exit, label %.select.workers.i

.select.workers.i:                                ; preds = %.await.work.i
  %8 = load i8, i8* %exec_status.i, align 1
  %is_active.i = icmp ne i8 %8, 0
  br i1 %is_active.i, label %.execute.parallel.i, label %.barrier.parallel.i

.execute.parallel.i:                              ; preds = %.select.workers.i
  br label %.barrier.parallel.i

.barrier.parallel.i:                              ; preds = %.execute.parallel.i, %.select.workers.i
  call void @llvm.nvvm.barrier0() #3
  br label %.await.work.i

__omp_offloading_806_1222644_main_l17_worker.exit: ; preds = %.await.work.i
  br label %.exit

.exit:                                            ; preds = %__omp_offloading_806_1222644_main_l17_worker.exit, %entry
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

!0 = !{i32 0, i32 2054, i32 19015236, !"main", i32 13, i32 0}
!1 = !{i32 0, i32 2054, i32 19015236, !"main", i32 17, i32 1}
!2 = !{void (i32*, i8*)* @__omp_offloading_806_1222644_main_l13, !"kernel", i32 1}
!3 = !{void (i32*, i8*)* @__omp_offloading_806_1222644_main_l17, !"kernel", i32 1}
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
; ModuleID = '/tmp/tmp-5e3454.bc'
source_filename = "tmp.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct.__tgt_offload_entry = type { i8*, i8*, i8*, i64, i32, i32, i32 }
%struct.__tgt_device_image = type { i8*, i8*, %struct.__tgt_offload_entry*, %struct.__tgt_offload_entry* }
%struct.__tgt_bin_desc = type { i32, %struct.__tgt_device_image*, %struct.__tgt_offload_entry*, %struct.__tgt_offload_entry* }
%struct.anon = type { i32* }
%struct.kmp_depend_info = type { i64, i64, i8 }
%struct.anon.0 = type { i32* }
%struct.kmp_task_t_with_privates = type { %struct.kmp_task_t, %struct..kmp_privates.t }
%struct.kmp_task_t = type { i8*, i32 (i32, i8*)*, i32, %union.kmp_cmplrdata_t, %union.kmp_cmplrdata_t, i32, i32, i32 }
%union.kmp_cmplrdata_t = type { i32 (i32, i8*)* }
%struct..kmp_privates.t = type { [1 x i8*], [1 x i8*], [1 x i64] }
%struct.kmp_task_t_with_privates.1 = type { %struct.kmp_task_t, %struct..kmp_privates.t.2 }
%struct..kmp_privates.t.2 = type { [1 x i8*], [1 x i8*], [1 x i64] }

$.omp_offloading.descriptor_reg = comdat any

@.str = private unnamed_addr constant [27 x i8] c"\0A\0ANUMBER OF DEVICES: %d\0A\0A\0A\00", align 1
@.str.1 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@__omp_offloading_806_1222644_main_l13.region_id = weak constant i8 0
@.offload_sizes = private unnamed_addr constant [1 x i64] [i64 4]
@.offload_maptypes = private unnamed_addr constant [1 x i64] [i64 35]
@.offload_maptypes.3 = private unnamed_addr constant [1 x i64] [i64 35]
@__omp_offloading_806_1222644_main_l17.region_id = weak constant i8 0
@.offload_sizes.4 = private unnamed_addr constant [1 x i64] [i64 4]
@.offload_maptypes.5 = private unnamed_addr constant [1 x i64] [i64 35]
@.offload_maptypes.7 = private unnamed_addr constant [1 x i64] [i64 35]
@1 = private unnamed_addr constant %ident_t { i32 0, i32 322, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@.str.10 = private unnamed_addr constant [14 x i8] c"result:  %d \0A\00", align 1
@.omp_offloading.entry_name = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_1222644_main_l13\00"
@.omp_offloading.entry_module = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_1222644_main_l13 = weak constant %struct.__tgt_offload_entry { i8* @__omp_offloading_806_1222644_main_l13.region_id, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entry_name.11 = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_1222644_main_l17\00"
@.omp_offloading.entry_module.12 = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_1222644_main_l17 = weak constant %struct.__tgt_offload_entry { i8* @__omp_offloading_806_1222644_main_l17.region_id, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name.11, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module.12, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
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
  %A = alloca i32, align 4
  call void @omp_set_num_threads(i32 2)
  %call = call i32 @omp_get_num_devices()
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str, i32 0, i32 0), i32 %call)
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 1, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*), i32* %A)
  %0 = load i32, i32* %A, align 4
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.10, i32 0, i32 0), i32 %0)
  ret i32 0
}

declare void @omp_set_num_threads(i32) #1

declare i32 @printf(i8*, ...) #1

declare i32 @omp_get_num_devices() #1

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i32* dereferenceable(4) %A) #2 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %A.addr = alloca i32*, align 8
  %.offload_baseptrs = alloca [1 x i8*], align 8
  %.offload_ptrs = alloca [1 x i8*], align 8
  %agg.captured = alloca %struct.anon, align 8
  %.dep.arr.addr = alloca [1 x %struct.kmp_depend_info], align 8
  %.offload_baseptrs1 = alloca [1 x i8*], align 8
  %.offload_ptrs2 = alloca [1 x i8*], align 8
  %agg.captured3 = alloca %struct.anon.0, align 8
  %.dep.arr.addr4 = alloca [1 x %struct.kmp_depend_info], align 8
  store i32* %.global_tid., i32** %.global_tid..addr, align 8
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8
  store i32* %A, i32** %A.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  %1 = load i32*, i32** %.global_tid..addr, align 8
  %2 = load i32, i32* %1, align 4
  %3 = call i32 @__kmpc_single(%ident_t* @0, i32 %2)
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %omp_if.then, label %omp_if.end

omp_if.then:                                      ; preds = %entry
  %5 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs, i32 0, i32 0
  %6 = bitcast i8** %5 to i32**
  store i32* %0, i32** %6, align 8
  %7 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs, i32 0, i32 0
  %8 = bitcast i8** %7 to i32**
  store i32* %0, i32** %8, align 8
  %9 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs, i32 0, i32 0
  %10 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs, i32 0, i32 0
  %11 = getelementptr inbounds %struct.anon, %struct.anon* %agg.captured, i32 0, i32 0
  store i32* %0, i32** %11, align 8
  %12 = call i8* @__kmpc_omp_target_task_alloc(%ident_t* @0, i32 %2, i32 1, i64 80, i64 8, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates*)* @.omp_task_entry. to i32 (i32, i8*)*), i64 0)
  %13 = bitcast i8* %12 to %struct.kmp_task_t_with_privates*
  %14 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %13, i32 0, i32 0
  %15 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %14, i32 0, i32 0
  %16 = load i8*, i8** %15, align 8
  %17 = bitcast %struct.anon* %agg.captured to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %16, i8* %17, i64 8, i32 8, i1 false)
  %18 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %13, i32 0, i32 1
  %19 = bitcast i8* %16 to %struct.anon*
  %20 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %18, i32 0, i32 0
  %21 = bitcast [1 x i8*]* %20 to i8*
  %22 = bitcast i8** %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %21, i8* %22, i64 8, i32 8, i1 false)
  %23 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %18, i32 0, i32 1
  %24 = bitcast [1 x i8*]* %23 to i8*
  %25 = bitcast i8** %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %24, i8* %25, i64 8, i32 8, i1 false)
  %26 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %18, i32 0, i32 2
  %27 = bitcast [1 x i64]* %26 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* bitcast ([1 x i64]* @.offload_sizes to i8*), i64 8, i32 8, i1 false)
  %28 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr, i64 0, i64 0
  %29 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %28, i32 0, i32 0
  %30 = ptrtoint i32* %0 to i64
  store i64 %30, i64* %29, align 8
  %31 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %28, i32 0, i32 1
  store i64 4, i64* %31, align 8
  %32 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %28, i32 0, i32 2
  store i8 3, i8* %32, align 8
  %33 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr, i32 0, i32 0
  %34 = bitcast %struct.kmp_depend_info* %33 to i8*
  %35 = call i32 @__kmpc_omp_task_with_deps(%ident_t* @0, i32 %2, i8* %12, i32 1, i8* %34, i32 0, i8* null)
  %36 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs1, i32 0, i32 0
  %37 = bitcast i8** %36 to i32**
  store i32* %0, i32** %37, align 8
  %38 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs2, i32 0, i32 0
  %39 = bitcast i8** %38 to i32**
  store i32* %0, i32** %39, align 8
  %40 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs1, i32 0, i32 0
  %41 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs2, i32 0, i32 0
  %42 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %agg.captured3, i32 0, i32 0
  store i32* %0, i32** %42, align 8
  %43 = call i8* @__kmpc_omp_target_task_alloc(%ident_t* @0, i32 %2, i32 1, i64 80, i64 8, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates.1*)* @.omp_task_entry..9 to i32 (i32, i8*)*), i64 1)
  %44 = bitcast i8* %43 to %struct.kmp_task_t_with_privates.1*
  %45 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %44, i32 0, i32 0
  %46 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %45, i32 0, i32 0
  %47 = load i8*, i8** %46, align 8
  %48 = bitcast %struct.anon.0* %agg.captured3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %47, i8* %48, i64 8, i32 8, i1 false)
  %49 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %44, i32 0, i32 1
  %50 = bitcast i8* %47 to %struct.anon.0*
  %51 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %49, i32 0, i32 0
  %52 = bitcast [1 x i8*]* %51 to i8*
  %53 = bitcast i8** %40 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %52, i8* %53, i64 8, i32 8, i1 false)
  %54 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %49, i32 0, i32 1
  %55 = bitcast [1 x i8*]* %54 to i8*
  %56 = bitcast i8** %41 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %55, i8* %56, i64 8, i32 8, i1 false)
  %57 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %49, i32 0, i32 2
  %58 = bitcast [1 x i64]* %57 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %58, i8* bitcast ([1 x i64]* @.offload_sizes.4 to i8*), i64 8, i32 8, i1 false)
  %59 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr4, i64 0, i64 0
  %60 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %59, i32 0, i32 0
  %61 = ptrtoint i32* %0 to i64
  store i64 %61, i64* %60, align 8
  %62 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %59, i32 0, i32 1
  store i64 4, i64* %62, align 8
  %63 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %59, i32 0, i32 2
  store i8 1, i8* %63, align 8
  %64 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr4, i32 0, i32 0
  %65 = bitcast %struct.kmp_depend_info* %64 to i8*
  %66 = call i32 @__kmpc_omp_task_with_deps(%ident_t* @0, i32 %2, i8* %43, i32 1, i8* %65, i32 0, i8* null)
  call void @__kmpc_end_single(%ident_t* @0, i32 %2)
  br label %omp_if.end

omp_if.end:                                       ; preds = %omp_if.then, %entry
  call void @__kmpc_barrier(%ident_t* @1, i32 %2)
  ret void
}

declare i32 @__kmpc_single(%ident_t*, i32)

declare void @__kmpc_end_single(%ident_t*, i32)

; Function Attrs: noinline nounwind uwtable
define internal void @__omp_offloading_806_1222644_main_l13(i32* dereferenceable(4) %A) #2 {
entry:
  %A.addr = alloca i32*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32* %A, i32** %A.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
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
  store i32 888, i32* %0, align 4
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

; Function Attrs: alwaysinline uwtable
define internal void @.omp_task_privates_map.(%struct..kmp_privates.t* noalias, [1 x i8*]** noalias, [1 x i8*]** noalias, [1 x i64]** noalias) #3 {
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
define internal i32 @.omp_task_entry.(i32, %struct.kmp_task_t_with_privates* noalias) #4 {
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
  call void (i8*, ...) %16(i8* %17, [1 x i8*]** %2, [1 x i8*]** %3, [1 x i64]** %4) #6
  %18 = getelementptr inbounds %struct.anon, %struct.anon* %15, i32 0, i32 0
  %ref.i = load i32*, i32** %18, align 8
  %19 = load [1 x i8*]*, [1 x i8*]** %2, align 8
  %20 = load [1 x i8*]*, [1 x i8*]** %3, align 8
  %21 = load [1 x i64]*, [1 x i64]** %4, align 8
  %22 = getelementptr inbounds [1 x i8*], [1 x i8*]* %19, i64 0, i64 0
  %23 = getelementptr inbounds [1 x i8*], [1 x i8*]* %20, i64 0, i64 0
  %24 = getelementptr inbounds [1 x i64], [1 x i64]* %21, i64 0, i64 0
  %25 = call i32 @__tgt_target_nowait(i64 0, i8* @__omp_offloading_806_1222644_main_l13.region_id, i32 1, i8** %22, i8** %23, i64* %24, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes.3, i32 0, i32 0), i8* %14) #6
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %omp_offload.failed.i, label %.omp_outlined..2.exit

omp_offload.failed.i:                             ; preds = %entry
  call void @__omp_offloading_806_1222644_main_l13(i32* %ref.i) #6
  br label %.omp_outlined..2.exit

.omp_outlined..2.exit:                            ; preds = %entry, %omp_offload.failed.i
  ret i32 0
}

declare i8* @__kmpc_omp_target_task_alloc(%ident_t*, i32, i32, i64, i64, i32 (i32, i8*)*, i64)

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #5

declare i32 @__kmpc_omp_task_with_deps(%ident_t*, i32, i8*, i32, i8*, i32, i8*)

; Function Attrs: noinline nounwind uwtable
define internal void @__omp_offloading_806_1222644_main_l17(i32* dereferenceable(4) %A) #2 {
entry:
  %A.addr = alloca i32*, align 8
  store i32* %A, i32** %A.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  %1 = load i32, i32* %0, align 4
  %add = add nsw i32 %1, 777
  store i32 %add, i32* %0, align 4
  ret void
}

; Function Attrs: alwaysinline uwtable
define internal void @.omp_task_privates_map..8(%struct..kmp_privates.t.2* noalias, [1 x i8*]** noalias, [1 x i8*]** noalias, [1 x i64]** noalias) #3 {
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
define internal i32 @.omp_task_entry..9(i32, %struct.kmp_task_t_with_privates.1* noalias) #4 {
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
  call void (i8*, ...) %16(i8* %17, [1 x i8*]** %2, [1 x i8*]** %3, [1 x i64]** %4) #6
  %18 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %15, i32 0, i32 0
  %ref.i = load i32*, i32** %18, align 8
  %19 = load [1 x i8*]*, [1 x i8*]** %2, align 8
  %20 = load [1 x i8*]*, [1 x i8*]** %3, align 8
  %21 = load [1 x i64]*, [1 x i64]** %4, align 8
  %22 = getelementptr inbounds [1 x i8*], [1 x i8*]* %19, i64 0, i64 0
  %23 = getelementptr inbounds [1 x i8*], [1 x i8*]* %20, i64 0, i64 0
  %24 = getelementptr inbounds [1 x i64], [1 x i64]* %21, i64 0, i64 0
  %25 = call i32 @__tgt_target_nowait(i64 1, i8* @__omp_offloading_806_1222644_main_l17.region_id, i32 1, i8** %22, i8** %23, i64* %24, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes.7, i32 0, i32 0), i8* %14) #6
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %omp_offload.failed.i, label %.omp_outlined..6.exit

omp_offload.failed.i:                             ; preds = %entry
  call void @__omp_offloading_806_1222644_main_l17(i32* %ref.i) #6
  br label %.omp_outlined..6.exit

.omp_outlined..6.exit:                            ; preds = %entry, %omp_offload.failed.i
  ret i32 0
}

declare void @__kmpc_barrier(%ident_t*, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: noinline uwtable
define internal void @.omp_offloading.descriptor_unreg(i8*) #4 section ".text.startup" comdat($.omp_offloading.descriptor_reg) {
entry:
  %.addr = alloca i8*, align 8
  store i8* %0, i8** %.addr, align 8
  %1 = call i32 @__tgt_unregister_lib(%struct.__tgt_bin_desc* @.omp_offloading.descriptor)
  ret void
}

declare i32 @__tgt_unregister_lib(%struct.__tgt_bin_desc*)

; Function Attrs: noinline uwtable
define linkonce hidden void @.omp_offloading.descriptor_reg() #4 section ".text.startup" comdat {
entry:
  %0 = call i32 @__tgt_register_lib(%struct.__tgt_bin_desc* @.omp_offloading.descriptor)
  %1 = call i32 @__cxa_atexit(void (i8*)* @.omp_offloading.descriptor_unreg, i8* bitcast (%struct.__tgt_bin_desc* @.omp_offloading.descriptor to i8*), i8* @__dso_handle) #6
  ret void
}

declare i32 @__tgt_register_lib(%struct.__tgt_bin_desc*)

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #6

attributes #0 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { alwaysinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind }
attributes #6 = { nounwind }

!omp_offload.info = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 0, i32 2054, i32 19015236, !"main", i32 13, i32 0}
!1 = !{i32 0, i32 2054, i32 19015236, !"main", i32 17, i32 1}
!2 = !{!"clang version 4.0.0 "}

; __CLANG_OFFLOAD_BUNDLE____END__ host-x86_64-unknown-linux-gnu
