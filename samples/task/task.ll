
; __CLANG_OFFLOAD_BUNDLE____START__ openmp-nvptx64-nvidia-cuda
; ModuleID = 'tgt.cpp'
source_filename = "tgt.cpp"
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

%struct.__openmp_nvptx_target_property_ty = type { i8, i32, i32 }
%struct.__openmp_nvptx_target_property_ty.0 = type { i8, i32, i32 }

@__omp_offloading_32_84f584e_main_l12_property = weak constant %struct.__openmp_nvptx_target_property_ty { i8 1, i32 0, i32 0 }, align 1
@__omp_offloading_32_84f584e_main_l14_property = weak constant %struct.__openmp_nvptx_target_property_ty.0 { i8 1, i32 0, i32 0 }, align 1

declare void @__kmpc_kernel_deinit(i16)

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() #0

; Function Attrs: noinline nounwind
define weak void @__omp_offloading_32_84f584e_main_l12(i32* dereferenceable(4) %A, i8* %scratchpad_ptr) #1 {
entry:
  %A.addr.i = alloca i32*, align 8
  %A.addr = alloca i32*, align 8
  %scratchpad_ptr.addr = alloca i8*, align 8
  store i32* %A, i32** %A.addr, align 8
  store i8* %scratchpad_ptr, i8** %scratchpad_ptr.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  %1 = call i32 @__omp_kernel_initialization() #3
  %2 = icmp eq i32 %1, 1
  br i1 %2, label %.master.i, label %__omp_offloading_32_84f584e_main_l12_impl__.exit

.master.i:                                        ; preds = %entry
  store i32* %0, i32** %A.addr.i, align 8
  %3 = load i32*, i32** %A.addr.i, align 8
  store i32 10, i32* %3, align 4
  call void @__kmpc_kernel_deinit(i16 0) #3
  call void @llvm.nvvm.barrier0() #3
  br label %__omp_offloading_32_84f584e_main_l12_impl__.exit

__omp_offloading_32_84f584e_main_l12_impl__.exit: ; preds = %entry, %.master.i
  ret void
}

declare i1 @__kmpc_kernel_parallel(i8**, i16)

; Function Attrs: noinline nounwind
define weak void @__omp_offloading_32_84f584e_main_l14(i32* dereferenceable(4) %A, i8* %scratchpad_ptr) #1 {
entry:
  %A.addr.i = alloca i32*, align 8
  %A.addr = alloca i32*, align 8
  %scratchpad_ptr.addr = alloca i8*, align 8
  store i32* %A, i32** %A.addr, align 8
  store i8* %scratchpad_ptr, i8** %scratchpad_ptr.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  %1 = call i32 @__omp_kernel_initialization.1() #3
  %2 = icmp eq i32 %1, 1
  br i1 %2, label %.master.i, label %__omp_offloading_32_84f584e_main_l14_impl__.exit

.master.i:                                        ; preds = %entry
  store i32* %0, i32** %A.addr.i, align 8
  %3 = load i32*, i32** %A.addr.i, align 8
  %4 = load i32, i32* %3, align 4
  %add.i = add nsw i32 %4, 100
  store i32 %add.i, i32* %3, align 4
  call void @__kmpc_kernel_deinit(i16 0) #3
  call void @llvm.nvvm.barrier0() #3
  br label %__omp_offloading_32_84f584e_main_l14_impl__.exit

__omp_offloading_32_84f584e_main_l14_impl__.exit: ; preds = %entry, %.master.i
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
  br i1 %should_terminate.i, label %__omp_offloading_32_84f584e_main_l12_worker.exit, label %.select.workers.i

.select.workers.i:                                ; preds = %.await.work.i
  %8 = load i8, i8* %exec_status.i, align 1
  %is_active.i = icmp ne i8 %8, 0
  br i1 %is_active.i, label %.execute.parallel.i, label %.barrier.parallel.i

.execute.parallel.i:                              ; preds = %.select.workers.i
  br label %.barrier.parallel.i

.barrier.parallel.i:                              ; preds = %.execute.parallel.i, %.select.workers.i
  call void @llvm.nvvm.barrier0() #3
  br label %.await.work.i

__omp_offloading_32_84f584e_main_l12_worker.exit: ; preds = %.await.work.i
  br label %.exit

.exit:                                            ; preds = %__omp_offloading_32_84f584e_main_l12_worker.exit, %entry
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
  br i1 %should_terminate.i, label %__omp_offloading_32_84f584e_main_l14_worker.exit, label %.select.workers.i

.select.workers.i:                                ; preds = %.await.work.i
  %8 = load i8, i8* %exec_status.i, align 1
  %is_active.i = icmp ne i8 %8, 0
  br i1 %is_active.i, label %.execute.parallel.i, label %.barrier.parallel.i

.execute.parallel.i:                              ; preds = %.select.workers.i
  br label %.barrier.parallel.i

.barrier.parallel.i:                              ; preds = %.execute.parallel.i, %.select.workers.i
  call void @llvm.nvvm.barrier0() #3
  br label %.await.work.i

__omp_offloading_32_84f584e_main_l14_worker.exit: ; preds = %.await.work.i
  br label %.exit

.exit:                                            ; preds = %__omp_offloading_32_84f584e_main_l14_worker.exit, %entry
  %9 = load i32, i32* %retval, align 4
  ret i32 %9
}

attributes #0 = { convergent nounwind }
attributes #1 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_52" "target-features"="+ptx60,-satom" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!omp_offload.info = !{!0, !1}
!nvvm.annotations = !{!2, !3, !4, !5, !4, !6, !6, !6, !6, !7, !7, !6}
!llvm.module.flags = !{!8}
!llvm.ident = !{!9}
!nvvm.internalize.after.link = !{}
!nvvmir.version = !{!10}

!0 = !{i32 0, i32 50, i32 139417678, !"main", i32 14, i32 1}
!1 = !{i32 0, i32 50, i32 139417678, !"main", i32 12, i32 0}
!2 = !{void (i32*, i8*)* @__omp_offloading_32_84f584e_main_l12, !"kernel", i32 1}
!3 = !{void (i32*, i8*)* @__omp_offloading_32_84f584e_main_l14, !"kernel", i32 1}
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

; __CLANG_OFFLOAD_BUNDLE____START__ openmp-x86_64-unknown-linux-gnu
; ModuleID = 'tgt.cpp'
source_filename = "tgt.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__tgt_offload_entry = type { i8*, i8*, i8*, i64, i32, i32, i32 }

@.omp_offloading.entry_name = internal unnamed_addr constant [37 x i8] c"__omp_offloading_32_84f584e_main_l12\00"
@.omp_offloading.entry_module = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_32_84f584e_main_l12 = weak constant %struct.__tgt_offload_entry { i8* bitcast (void (i32*)* @__omp_offloading_32_84f584e_main_l12 to i8*), i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entry_name.1 = internal unnamed_addr constant [37 x i8] c"__omp_offloading_32_84f584e_main_l14\00"
@.omp_offloading.entry_module.2 = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_32_84f584e_main_l14 = weak constant %struct.__tgt_offload_entry { i8* bitcast (void (i32*)* @__omp_offloading_32_84f584e_main_l14 to i8*), i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.omp_offloading.entry_name.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module.2, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1

; Function Attrs: noinline nounwind uwtable
define weak void @__omp_offloading_32_84f584e_main_l12(i32* dereferenceable(4) %A) #0 {
entry:
  %A.addr = alloca i32*, align 8
  store i32* %A, i32** %A.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  store i32 10, i32* %0, align 4
  ret void
}

; Function Attrs: noinline nounwind uwtable
define weak void @__omp_offloading_32_84f584e_main_l14(i32* dereferenceable(4) %A) #0 {
entry:
  %A.addr = alloca i32*, align 8
  store i32* %A, i32** %A.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  %1 = load i32, i32* %0, align 4
  %add = add nsw i32 %1, 100
  store i32 %add, i32* %0, align 4
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!omp_offload.info = !{!0, !1}
!llvm.module.flags = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 0, i32 50, i32 139417678, !"main", i32 14, i32 1}
!1 = !{i32 0, i32 50, i32 139417678, !"main", i32 12, i32 0}
!2 = !{i32 1, !"PIC Level", i32 2}
!3 = !{!"clang version 4.0.0 "}

; __CLANG_OFFLOAD_BUNDLE____END__ openmp-x86_64-unknown-linux-gnu

; __CLANG_OFFLOAD_BUNDLE____START__ host-x86_64-unknown-linux-gnu
; ModuleID = '/tmp/tgt-4a3421.bc'
source_filename = "tgt.cpp"
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
%struct.kmp_task_t = type { i8*, i32 (i32, i8*)*, i32, %union.kmp_cmplrdata_t, %union.kmp_cmplrdata_t }
%union.kmp_cmplrdata_t = type { i32 (i32, i8*)* }
%struct..kmp_privates.t = type { [1 x i8*], [1 x i8*], [1 x i64] }
%struct.kmp_task_t_with_privates.1 = type { %struct.kmp_task_t, %struct..kmp_privates.t.2 }
%struct..kmp_privates.t.2 = type { [1 x i8*], [1 x i8*], [1 x i64] }

$.omp_offloading.descriptor_reg = comdat any

@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@__omp_offloading_32_84f584e_main_l12.region_id = weak constant i8 0
@.offload_sizes = private unnamed_addr constant [1 x i64] [i64 4]
@.offload_maptypes = private unnamed_addr constant [1 x i64] [i64 35]
@.offload_maptypes.2 = private unnamed_addr constant [1 x i64] [i64 35]
@__omp_offloading_32_84f584e_main_l14.region_id = weak constant i8 0
@.offload_sizes.3 = private unnamed_addr constant [1 x i64] [i64 4]
@.offload_maptypes.4 = private unnamed_addr constant [1 x i64] [i64 35]
@.offload_maptypes.6 = private unnamed_addr constant [1 x i64] [i64 35]
@1 = private unnamed_addr constant %ident_t { i32 0, i32 322, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@.str.9 = private unnamed_addr constant [13 x i8] c"result:  %d\0A\00", align 1
@.omp_offloading.entry_name = internal unnamed_addr constant [37 x i8] c"__omp_offloading_32_84f584e_main_l12\00"
@.omp_offloading.entry_module = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_32_84f584e_main_l12 = weak constant %struct.__tgt_offload_entry { i8* @__omp_offloading_32_84f584e_main_l12.region_id, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entry_name.10 = internal unnamed_addr constant [37 x i8] c"__omp_offloading_32_84f584e_main_l14\00"
@.omp_offloading.entry_module.11 = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_32_84f584e_main_l14 = weak constant %struct.__tgt_offload_entry { i8* @__omp_offloading_32_84f584e_main_l14.region_id, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.omp_offloading.entry_name.10, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module.11, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entries_begin = external constant %struct.__tgt_offload_entry
@.omp_offloading.entries_end = external constant %struct.__tgt_offload_entry
@.omp_offloading.img_start.nvptx64-nvidia-cuda = external constant i8
@.omp_offloading.img_end.nvptx64-nvidia-cuda = external constant i8
@.omp_offloading.img_start.x86_64-unknown-linux-gnu = external constant i8
@.omp_offloading.img_end.x86_64-unknown-linux-gnu = external constant i8
@.omp_offloading.device_images = internal unnamed_addr constant [2 x %struct.__tgt_device_image] [%struct.__tgt_device_image { i8* @.omp_offloading.img_start.nvptx64-nvidia-cuda, i8* @.omp_offloading.img_end.nvptx64-nvidia-cuda, %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }, %struct.__tgt_device_image { i8* @.omp_offloading.img_start.x86_64-unknown-linux-gnu, i8* @.omp_offloading.img_end.x86_64-unknown-linux-gnu, %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }], comdat($.omp_offloading.descriptor_reg), align 8
@.omp_offloading.descriptor = internal constant %struct.__tgt_bin_desc { i32 2, %struct.__tgt_device_image* getelementptr inbounds ([2 x %struct.__tgt_device_image], [2 x %struct.__tgt_device_image]* @.omp_offloading.device_images, i32 0, i32 0), %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }, comdat($.omp_offloading.descriptor_reg), align 8
@__dso_handle = external global i8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 0, void ()* @.omp_offloading.descriptor_reg, i8* bitcast (void ()* @.omp_offloading.descriptor_reg to i8*) }]

; Function Attrs: noinline norecurse uwtable
define i32 @main() #0 {
entry:
  %A = alloca i32, align 4
  store i32 1, i32* %A, align 4
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 1, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*), i32* %A)
  %0 = load i32, i32* %A, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.9, i32 0, i32 0), i32 %0)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i32* dereferenceable(4) %A) #1 {
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
  %12 = call i8* @__kmpc_omp_target_task_alloc(%ident_t* @0, i32 %2, i32 1, i64 64, i64 8, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates*)* @.omp_task_entry. to i32 (i32, i8*)*), i64 0)
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
  %36 = call i32 @__kmpc_omp_taskwait(%ident_t* @0, i32 %2)
  %37 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs1, i32 0, i32 0
  %38 = bitcast i8** %37 to i32**
  store i32* %0, i32** %38, align 8
  %39 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs2, i32 0, i32 0
  %40 = bitcast i8** %39 to i32**
  store i32* %0, i32** %40, align 8
  %41 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs1, i32 0, i32 0
  %42 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs2, i32 0, i32 0
  %43 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %agg.captured3, i32 0, i32 0
  store i32* %0, i32** %43, align 8
  %44 = call i8* @__kmpc_omp_target_task_alloc(%ident_t* @0, i32 %2, i32 1, i64 64, i64 8, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates.1*)* @.omp_task_entry..8 to i32 (i32, i8*)*), i64 3)
  %45 = bitcast i8* %44 to %struct.kmp_task_t_with_privates.1*
  %46 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %45, i32 0, i32 0
  %47 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %46, i32 0, i32 0
  %48 = load i8*, i8** %47, align 8
  %49 = bitcast %struct.anon.0* %agg.captured3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %48, i8* %49, i64 8, i32 8, i1 false)
  %50 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %45, i32 0, i32 1
  %51 = bitcast i8* %48 to %struct.anon.0*
  %52 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %50, i32 0, i32 0
  %53 = bitcast [1 x i8*]* %52 to i8*
  %54 = bitcast i8** %41 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %53, i8* %54, i64 8, i32 8, i1 false)
  %55 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %50, i32 0, i32 1
  %56 = bitcast [1 x i8*]* %55 to i8*
  %57 = bitcast i8** %42 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %56, i8* %57, i64 8, i32 8, i1 false)
  %58 = getelementptr inbounds %struct..kmp_privates.t.2, %struct..kmp_privates.t.2* %50, i32 0, i32 2
  %59 = bitcast [1 x i64]* %58 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %59, i8* bitcast ([1 x i64]* @.offload_sizes.3 to i8*), i64 8, i32 8, i1 false)
  %60 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr4, i64 0, i64 0
  %61 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %60, i32 0, i32 0
  %62 = ptrtoint i32* %0 to i64
  store i64 %62, i64* %61, align 8
  %63 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %60, i32 0, i32 1
  store i64 4, i64* %63, align 8
  %64 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %60, i32 0, i32 2
  store i8 1, i8* %64, align 8
  %65 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr4, i32 0, i32 0
  %66 = bitcast %struct.kmp_depend_info* %65 to i8*
  %67 = call i32 @__kmpc_omp_task_with_deps(%ident_t* @0, i32 %2, i8* %44, i32 1, i8* %66, i32 0, i8* null)
  %68 = call i32 @__kmpc_omp_taskwait(%ident_t* @0, i32 %2)
  call void @__kmpc_end_single(%ident_t* @0, i32 %2)
  br label %omp_if.end

omp_if.end:                                       ; preds = %omp_if.then, %entry
  call void @__kmpc_barrier(%ident_t* @1, i32 %2)
  ret void
}

declare i32 @__kmpc_single(%ident_t*, i32)

declare void @__kmpc_end_single(%ident_t*, i32)

; Function Attrs: noinline nounwind uwtable
define internal void @__omp_offloading_32_84f584e_main_l12(i32* dereferenceable(4) %A) #1 {
entry:
  %A.addr = alloca i32*, align 8
  store i32* %A, i32** %A.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  store i32 10, i32* %0, align 4
  ret void
}

declare i32 @__tgt_target(i64, i8*, i32, i8**, i8**, i64*, i64*)

; Function Attrs: alwaysinline uwtable
define internal void @.omp_task_privates_map.(%struct..kmp_privates.t* noalias, [1 x i8*]** noalias, [1 x i8*]** noalias, [1 x i64]** noalias) #2 {
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
define internal i32 @.omp_task_entry.(i32, %struct.kmp_task_t_with_privates* noalias) #3 {
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
  %25 = call i32 @__tgt_target(i64 0, i8* @__omp_offloading_32_84f584e_main_l12.region_id, i32 1, i8** %22, i8** %23, i64* %24, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes.2, i32 0, i32 0)) #6
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %omp_offload.failed.i, label %.omp_outlined..1.exit

omp_offload.failed.i:                             ; preds = %entry
  call void @__omp_offloading_32_84f584e_main_l12(i32* %ref.i) #6
  br label %.omp_outlined..1.exit

.omp_outlined..1.exit:                            ; preds = %entry, %omp_offload.failed.i
  ret i32 0
}

declare i8* @__kmpc_omp_target_task_alloc(%ident_t*, i32, i32, i64, i64, i32 (i32, i8*)*, i64)

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #4

declare i32 @__kmpc_omp_task_with_deps(%ident_t*, i32, i8*, i32, i8*, i32, i8*)

declare i32 @__kmpc_omp_taskwait(%ident_t*, i32)

; Function Attrs: noinline nounwind uwtable
define internal void @__omp_offloading_32_84f584e_main_l14(i32* dereferenceable(4) %A) #1 {
entry:
  %A.addr = alloca i32*, align 8
  store i32* %A, i32** %A.addr, align 8
  %0 = load i32*, i32** %A.addr, align 8
  %1 = load i32, i32* %0, align 4
  %add = add nsw i32 %1, 100
  store i32 %add, i32* %0, align 4
  ret void
}

; Function Attrs: alwaysinline uwtable
define internal void @.omp_task_privates_map..7(%struct..kmp_privates.t.2* noalias, [1 x i8*]** noalias, [1 x i8*]** noalias, [1 x i64]** noalias) #2 {
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
define internal i32 @.omp_task_entry..8(i32, %struct.kmp_task_t_with_privates.1* noalias) #3 {
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
  store void (i8*, ...)* bitcast (void (%struct..kmp_privates.t.2*, [1 x i8*]**, [1 x i8*]**, [1 x i64]**)* @.omp_task_privates_map..7 to void (i8*, ...)*), void (i8*, ...)** %.copy_fn..addr.i, align 8
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
  %25 = call i32 @__tgt_target(i64 3, i8* @__omp_offloading_32_84f584e_main_l14.region_id, i32 1, i8** %22, i8** %23, i64* %24, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes.6, i32 0, i32 0)) #6
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %omp_offload.failed.i, label %.omp_outlined..5.exit

omp_offload.failed.i:                             ; preds = %entry
  call void @__omp_offloading_32_84f584e_main_l14(i32* %ref.i) #6
  br label %.omp_outlined..5.exit

.omp_outlined..5.exit:                            ; preds = %entry, %omp_offload.failed.i
  ret i32 0
}

declare void @__kmpc_barrier(%ident_t*, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

declare i32 @printf(i8*, ...) #5

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
  %1 = call i32 @__cxa_atexit(void (i8*)* @.omp_offloading.descriptor_unreg, i8* bitcast (%struct.__tgt_bin_desc* @.omp_offloading.descriptor to i8*), i8* @__dso_handle) #6
  ret void
}

declare i32 @__tgt_register_lib(%struct.__tgt_bin_desc*)

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #6

attributes #0 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { alwaysinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind }

!omp_offload.info = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 0, i32 50, i32 139417678, !"main", i32 14, i32 1}
!1 = !{i32 0, i32 50, i32 139417678, !"main", i32 12, i32 0}
!2 = !{!"clang version 4.0.0 "}

; __CLANG_OFFLOAD_BUNDLE____END__ host-x86_64-unknown-linux-gnu
