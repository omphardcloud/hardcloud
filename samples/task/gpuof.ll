
; __CLANG_OFFLOAD_BUNDLE____START__ openmp-x86_64-unknown-linux-gnu
; ModuleID = 'gpuoff.cpp'
source_filename = "gpuoff.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct.__tgt_offload_entry = type { i8*, i8*, i8*, i64, i32, i32, i32 }

@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2050, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@2 = private unnamed_addr constant %ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@.omp_offloading.entry_name = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_122265b_main_l16\00"
@.omp_offloading.entry_module = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_122265b_main_l16 = weak constant %struct.__tgt_offload_entry { i8* bitcast (void (i64, i64, i32*)* @__omp_offloading_806_122265b_main_l16 to i8*), i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1

; Function Attrs: noinline nounwind uwtable
define weak void @__omp_offloading_806_122265b_main_l16(i64 %start, i64 %end, i32* %image) #0 {
entry:
  %start.addr = alloca i64, align 8
  %end.addr = alloca i64, align 8
  %image.addr = alloca i32*, align 8
  %start.casted = alloca i64, align 8
  %end.casted = alloca i64, align 8
  store i64 %start, i64* %start.addr, align 8
  store i64 %end, i64* %end.addr, align 8
  store i32* %image, i32** %image.addr, align 8
  %conv = bitcast i64* %start.addr to i32*
  %conv1 = bitcast i64* %end.addr to i32*
  %0 = load i32, i32* %conv, align 8
  %conv2 = bitcast i64* %start.casted to i32*
  store i32 %0, i32* %conv2, align 4
  %1 = load i64, i64* %start.casted, align 8
  %2 = load i32, i32* %conv1, align 8
  %conv3 = bitcast i64* %end.casted to i32*
  store i32 %2, i32* %conv3, align 4
  %3 = load i64, i64* %end.casted, align 8
  %4 = load i32*, i32** %image.addr, align 8
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_teams(%ident_t* @1, i32 3, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i64, i64, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*), i64 %1, i64 %3, i32* %4)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %start, i64 %end, i32* %image) #0 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %start.addr = alloca i64, align 8
  %end.addr = alloca i64, align 8
  %image.addr = alloca i32*, align 8
  %.omp.iv = alloca i64, align 8
  %tmp = alloca i32, align 4
  %tmp2 = alloca i32, align 4
  %.capture_expr. = alloca i32, align 4
  %.capture_expr.5 = alloca i32, align 4
  %.capture_expr.7 = alloca i64, align 8
  %y = alloca i32, align 4
  %x = alloca i32, align 4
  %.omp.lb = alloca i64, align 8
  %.omp.ub = alloca i64, align 8
  %.omp.stride = alloca i64, align 8
  %.omp.is_last = alloca i32, align 4
  %start18 = alloca i32, align 4
  %end20 = alloca i32, align 4
  %image22 = alloca i32*, align 8
  %0 = call i32 @__kmpc_global_thread_num(%ident_t* @1)
  %start.casted = alloca i64, align 8
  %end.casted = alloca i64, align 8
  store i32* %.global_tid., i32** %.global_tid..addr, align 8
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8
  store i64 %start, i64* %start.addr, align 8
  store i64 %end, i64* %end.addr, align 8
  store i32* %image, i32** %image.addr, align 8
  %conv = bitcast i64* %start.addr to i32*
  %conv1 = bitcast i64* %end.addr to i32*
  %1 = load i32, i32* %conv, align 8
  store i32 %1, i32* %.capture_expr., align 4
  %2 = load i32, i32* %conv1, align 8
  store i32 %2, i32* %.capture_expr.5, align 4
  %3 = load i32, i32* %.capture_expr.5, align 4
  %4 = load i32, i32* %.capture_expr., align 4
  %sub = sub nsw i32 %3, %4
  %sub8 = sub nsw i32 %sub, 1
  %add = add nsw i32 %sub8, 1
  %div = sdiv i32 %add, 1
  %conv9 = sext i32 %div to i64
  %mul = mul nsw i64 %conv9, 100
  %sub10 = sub nsw i64 %mul, 1
  store i64 %sub10, i64* %.capture_expr.7, align 8
  %5 = load i32, i32* %.capture_expr., align 4
  store i32 %5, i32* %y, align 4
  store i32 0, i32* %x, align 4
  %6 = load i32, i32* %.capture_expr., align 4
  %7 = load i32, i32* %.capture_expr.5, align 4
  %cmp = icmp slt i32 %6, %7
  br i1 %cmp, label %omp.precond.then, label %omp.precond.end

omp.precond.then:                                 ; preds = %entry
  store i64 0, i64* %.omp.lb, align 8
  %8 = load i64, i64* %.capture_expr.7, align 8
  store i64 %8, i64* %.omp.ub, align 8
  store i64 1, i64* %.omp.stride, align 8
  store i32 0, i32* %.omp.is_last, align 4
  %9 = load i32, i32* %conv, align 8
  store i32 %9, i32* %start18, align 4
  %10 = load i32, i32* %conv1, align 8
  store i32 %10, i32* %end20, align 4
  %11 = load i32*, i32** %image.addr, align 8
  store i32* %11, i32** %image22, align 8
  call void @__kmpc_for_static_init_8(%ident_t* @0, i32 %0, i32 92, i32* %.omp.is_last, i64* %.omp.lb, i64* %.omp.ub, i64* %.omp.stride, i64 1, i64 1)
  %12 = load i64, i64* %.omp.ub, align 8
  %13 = load i64, i64* %.capture_expr.7, align 8
  %cmp23 = icmp sgt i64 %12, %13
  br i1 %cmp23, label %cond.true, label %cond.false

cond.true:                                        ; preds = %omp.precond.then
  %14 = load i64, i64* %.capture_expr.7, align 8
  br label %cond.end

cond.false:                                       ; preds = %omp.precond.then
  %15 = load i64, i64* %.omp.ub, align 8
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i64 [ %14, %cond.true ], [ %15, %cond.false ]
  store i64 %cond, i64* %.omp.ub, align 8
  %16 = load i64, i64* %.omp.lb, align 8
  store i64 %16, i64* %.omp.iv, align 8
  br label %omp.inner.for.cond

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %17 = load i64, i64* %.omp.iv, align 8
  %18 = load i64, i64* %.omp.ub, align 8
  %cmp24 = icmp sle i64 %17, %18
  br i1 %cmp24, label %omp.inner.for.body, label %omp.inner.for.end

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %19 = load i64, i64* %.omp.lb, align 8
  %20 = load i64, i64* %.omp.ub, align 8
  %21 = load i32, i32* %start18, align 4
  %conv25 = bitcast i64* %start.casted to i32*
  store i32 %21, i32* %conv25, align 4
  %22 = load i64, i64* %start.casted, align 8
  %23 = load i32, i32* %end20, align 4
  %conv26 = bitcast i64* %end.casted to i32*
  store i32 %23, i32* %conv26, align 4
  %24 = load i64, i64* %end.casted, align 8
  %25 = load i32*, i32** %image22, align 8
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @1, i32 5, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i64, i64, i64, i64, i32*)* @.omp_outlined..1 to void (i32*, i32*, ...)*), i64 %19, i64 %20, i64 %22, i64 %24, i32* %25)
  br label %omp.inner.for.inc

omp.inner.for.inc:                                ; preds = %omp.inner.for.body
  %26 = load i64, i64* %.omp.iv, align 8
  %27 = load i64, i64* %.omp.stride, align 8
  %add27 = add nsw i64 %26, %27
  store i64 %add27, i64* %.omp.iv, align 8
  br label %omp.inner.for.cond

omp.inner.for.end:                                ; preds = %omp.inner.for.cond
  br label %omp.loop.exit

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %0)
  br label %omp.precond.end

omp.precond.end:                                  ; preds = %omp.loop.exit, %entry
  ret void
}

declare i32 @__kmpc_global_thread_num(%ident_t*)

declare void @__kmpc_for_static_init_8(%ident_t*, i32, i32, i32*, i64*, i64*, i64*, i64, i64)

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_outlined..1(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i64 %start, i64 %end, i32* %image) #0 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %.previous.lb..addr = alloca i64, align 8
  %.previous.ub..addr = alloca i64, align 8
  %start.addr = alloca i64, align 8
  %end.addr = alloca i64, align 8
  %image.addr = alloca i32*, align 8
  %.omp.iv = alloca i64, align 8
  %tmp = alloca i32, align 4
  %tmp2 = alloca i32, align 4
  %.capture_expr. = alloca i32, align 4
  %.capture_expr.5 = alloca i32, align 4
  %.capture_expr.7 = alloca i64, align 8
  %y = alloca i32, align 4
  %x = alloca i32, align 4
  %.omp.lb = alloca i64, align 8
  %.omp.ub = alloca i64, align 8
  %.omp.stride = alloca i64, align 8
  %.omp.is_last = alloca i32, align 4
  %start18 = alloca i32, align 4
  %end20 = alloca i32, align 4
  %image22 = alloca i32*, align 8
  %0 = call i32 @__kmpc_global_thread_num(%ident_t* @1)
  store i32* %.global_tid., i32** %.global_tid..addr, align 8
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8
  store i64 %.previous.lb., i64* %.previous.lb..addr, align 8
  store i64 %.previous.ub., i64* %.previous.ub..addr, align 8
  store i64 %start, i64* %start.addr, align 8
  store i64 %end, i64* %end.addr, align 8
  store i32* %image, i32** %image.addr, align 8
  %conv = bitcast i64* %start.addr to i32*
  %conv1 = bitcast i64* %end.addr to i32*
  %1 = load i32, i32* %conv, align 8
  store i32 %1, i32* %.capture_expr., align 4
  %2 = load i32, i32* %conv1, align 8
  store i32 %2, i32* %.capture_expr.5, align 4
  %3 = load i32, i32* %.capture_expr.5, align 4
  %4 = load i32, i32* %.capture_expr., align 4
  %sub = sub nsw i32 %3, %4
  %sub8 = sub nsw i32 %sub, 1
  %add = add nsw i32 %sub8, 1
  %div = sdiv i32 %add, 1
  %conv9 = sext i32 %div to i64
  %mul = mul nsw i64 %conv9, 100
  %sub10 = sub nsw i64 %mul, 1
  store i64 %sub10, i64* %.capture_expr.7, align 8
  %5 = load i32, i32* %.capture_expr., align 4
  store i32 %5, i32* %y, align 4
  store i32 0, i32* %x, align 4
  %6 = load i32, i32* %.capture_expr., align 4
  %7 = load i32, i32* %.capture_expr.5, align 4
  %cmp = icmp slt i32 %6, %7
  br i1 %cmp, label %omp.precond.then, label %omp.precond.end

omp.precond.then:                                 ; preds = %entry
  store i64 0, i64* %.omp.lb, align 8
  %8 = load i64, i64* %.capture_expr.7, align 8
  store i64 %8, i64* %.omp.ub, align 8
  store i64 1, i64* %.omp.stride, align 8
  store i32 0, i32* %.omp.is_last, align 4
  %9 = load i64, i64* %.previous.lb..addr, align 8
  %10 = load i64, i64* %.previous.ub..addr, align 8
  store i64 %9, i64* %.omp.lb, align 8
  store i64 %10, i64* %.omp.ub, align 8
  %11 = load i32, i32* %conv, align 8
  store i32 %11, i32* %start18, align 4
  %12 = load i32, i32* %conv1, align 8
  store i32 %12, i32* %end20, align 4
  %13 = load i32*, i32** %image.addr, align 8
  store i32* %13, i32** %image22, align 8
  call void @__kmpc_for_static_init_8(%ident_t* @2, i32 %0, i32 34, i32* %.omp.is_last, i64* %.omp.lb, i64* %.omp.ub, i64* %.omp.stride, i64 1, i64 1)
  %14 = load i64, i64* %.omp.ub, align 8
  %15 = load i64, i64* %.capture_expr.7, align 8
  %cmp23 = icmp sgt i64 %14, %15
  br i1 %cmp23, label %cond.true, label %cond.false

cond.true:                                        ; preds = %omp.precond.then
  %16 = load i64, i64* %.capture_expr.7, align 8
  br label %cond.end

cond.false:                                       ; preds = %omp.precond.then
  %17 = load i64, i64* %.omp.ub, align 8
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i64 [ %16, %cond.true ], [ %17, %cond.false ]
  store i64 %cond, i64* %.omp.ub, align 8
  %18 = load i64, i64* %.omp.lb, align 8
  store i64 %18, i64* %.omp.iv, align 8
  br label %omp.inner.for.cond

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %19 = load i64, i64* %.omp.iv, align 8
  %20 = load i64, i64* %.omp.ub, align 8
  %cmp24 = icmp sle i64 %19, %20
  br i1 %cmp24, label %omp.inner.for.body, label %omp.inner.for.end

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %21 = load i32, i32* %.capture_expr., align 4
  %conv25 = sext i32 %21 to i64
  %22 = load i64, i64* %.omp.iv, align 8
  %div26 = sdiv i64 %22, 100
  %mul27 = mul nsw i64 %div26, 1
  %add28 = add nsw i64 %conv25, %mul27
  %conv29 = trunc i64 %add28 to i32
  store i32 %conv29, i32* %y, align 4
  %23 = load i64, i64* %.omp.iv, align 8
  %rem = srem i64 %23, 100
  %mul30 = mul nsw i64 %rem, 1
  %add31 = add nsw i64 0, %mul30
  %conv32 = trunc i64 %add31 to i32
  store i32 %conv32, i32* %x, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32, i32* %y, align 4
  %add33 = add nsw i32 %24, %25
  %26 = load i32*, i32** %image22, align 8
  %27 = load i32, i32* %y, align 4
  %mul34 = mul nsw i32 %27, 100
  %28 = load i32, i32* %x, align 4
  %add35 = add nsw i32 %mul34, %28
  %idxprom = sext i32 %add35 to i64
  %arrayidx = getelementptr inbounds i32, i32* %26, i64 %idxprom
  store i32 %add33, i32* %arrayidx, align 4
  br label %omp.body.continue

omp.body.continue:                                ; preds = %omp.inner.for.body
  br label %omp.inner.for.inc

omp.inner.for.inc:                                ; preds = %omp.body.continue
  %29 = load i64, i64* %.omp.iv, align 8
  %add36 = add nsw i64 %29, 1
  store i64 %add36, i64* %.omp.iv, align 8
  br label %omp.inner.for.cond, !llvm.loop !3

omp.inner.for.end:                                ; preds = %omp.inner.for.cond
  br label %omp.loop.exit

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %0)
  %30 = load i32, i32* %.omp.is_last, align 4
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %.omp.final.then, label %.omp.final.done

.omp.final.then:                                  ; preds = %omp.loop.exit
  %32 = load i32, i32* %.capture_expr., align 4
  %33 = load i32, i32* %.capture_expr.5, align 4
  %34 = load i32, i32* %.capture_expr., align 4
  %sub37 = sub nsw i32 %33, %34
  %sub38 = sub nsw i32 %sub37, 1
  %add39 = add nsw i32 %sub38, 1
  %div40 = sdiv i32 %add39, 1
  %mul41 = mul nsw i32 %div40, 1
  %add42 = add nsw i32 %32, %mul41
  store i32 %add42, i32* %y, align 4
  store i32 100, i32* %x, align 4
  br label %.omp.final.done

.omp.final.done:                                  ; preds = %.omp.final.then, %omp.loop.exit
  br label %omp.precond.end

omp.precond.end:                                  ; preds = %.omp.final.done, %entry
  ret void
}

declare void @__kmpc_for_static_fini(%ident_t*, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

declare void @__kmpc_fork_teams(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!omp_offload.info = !{!0}
!llvm.module.flags = !{!1}
!llvm.ident = !{!2}

!0 = !{i32 0, i32 2054, i32 19015259, !"main", i32 16, i32 0}
!1 = !{i32 1, !"PIC Level", i32 2}
!2 = !{!"clang version 4.0.0 "}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.vectorize.enable", i1 true}

; __CLANG_OFFLOAD_BUNDLE____END__ openmp-x86_64-unknown-linux-gnu

; __CLANG_OFFLOAD_BUNDLE____START__ openmp-nvptx64-nvidia-cuda
; ModuleID = 'gpuoff.cpp'
source_filename = "gpuoff.cpp"
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct.__openmp_nvptx_target_property_ty = type { i8, i32, i32 }

@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2050, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@__omp_offloading_806_122265b_main_l16_property = weak constant %struct.__openmp_nvptx_target_property_ty zeroinitializer, align 1

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #0

declare void @__kmpc_spmd_kernel_init(i32, i16, i16)

; Function Attrs: noinline nounwind
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %start, i64 %end, i32* %image) #1 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %start.addr = alloca i64, align 8
  %end.addr = alloca i64, align 8
  %image.addr = alloca i32*, align 8
  %.omp.iv = alloca i64, align 8
  %tmp = alloca i32, align 4
  %tmp2 = alloca i32, align 4
  %.capture_expr. = alloca i32, align 4
  %.capture_expr.5 = alloca i32, align 4
  %.capture_expr.7 = alloca i64, align 8
  %y = alloca i32, align 4
  %x = alloca i32, align 4
  %.omp.lb = alloca i64, align 8
  %.omp.ub = alloca i64, align 8
  %.omp.stride = alloca i64, align 8
  %.omp.is_last = alloca i32, align 4
  %start18 = alloca i32, align 4
  %end20 = alloca i32, align 4
  %image22 = alloca i32*, align 8
  store i32* %.global_tid., i32** %.global_tid..addr, align 8
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8
  store i64 %start, i64* %start.addr, align 8
  store i64 %end, i64* %end.addr, align 8
  store i32* %image, i32** %image.addr, align 8
  %conv = bitcast i64* %start.addr to i32*
  %conv1 = bitcast i64* %end.addr to i32*
  %0 = load i32, i32* %conv, align 8
  store i32 %0, i32* %.capture_expr., align 4
  %1 = load i32, i32* %conv1, align 8
  store i32 %1, i32* %.capture_expr.5, align 4
  %2 = load i32, i32* %.capture_expr.5, align 4
  %3 = load i32, i32* %.capture_expr., align 4
  %sub = sub nsw i32 %2, %3
  %sub8 = sub nsw i32 %sub, 1
  %add = add nsw i32 %sub8, 1
  %div = sdiv i32 %add, 1
  %conv9 = sext i32 %div to i64
  %mul = mul nsw i64 %conv9, 100
  %sub10 = sub nsw i64 %mul, 1
  store i64 %sub10, i64* %.capture_expr.7, align 8
  %4 = load i32, i32* %.capture_expr., align 4
  store i32 %4, i32* %y, align 4
  store i32 0, i32* %x, align 4
  %5 = load i32, i32* %.capture_expr., align 4
  %6 = load i32, i32* %.capture_expr.5, align 4
  %cmp = icmp slt i32 %5, %6
  br i1 %cmp, label %omp.precond.then, label %omp.precond.end

omp.precond.then:                                 ; preds = %entry
  store i64 0, i64* %.omp.lb, align 8
  %7 = load i64, i64* %.capture_expr.7, align 8
  store i64 %7, i64* %.omp.ub, align 8
  store i64 1, i64* %.omp.stride, align 8
  store i32 0, i32* %.omp.is_last, align 4
  %8 = load i32, i32* %conv, align 8
  store i32 %8, i32* %start18, align 4
  %9 = load i32, i32* %conv1, align 8
  store i32 %9, i32* %end20, align 4
  %10 = load i32*, i32** %image.addr, align 8
  store i32* %10, i32** %image22, align 8
  %nvptx_block_id = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !9
  %nvptx_num_threads = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !range !10
  %num_workers = sub nuw i32 %nvptx_num_threads, 32
  %11 = mul i32 %nvptx_block_id, %num_workers
  %nvptx_num_threads23 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !range !10
  %nvptx_warp_size = call i32 @llvm.nvvm.read.ptx.sreg.warpsize(), !range !11
  %12 = sub i32 %nvptx_warp_size, 1
  %13 = sub i32 %nvptx_num_threads23, 1
  %14 = xor i32 %12, -1
  %master_tid = and i32 %13, %14
  %15 = sub nuw i32 %master_tid, 1
  %nvptx_tid = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !12
  %team_tid = and i32 %nvptx_tid, %15
  %global_tid = add i32 %11, %team_tid
  call void @__kmpc_for_static_init_8_simple_spmd(%ident_t* @0, i32 %global_tid, i32 93, i32* %.omp.is_last, i64* %.omp.lb, i64* %.omp.ub, i64* %.omp.stride, i64 1, i64 1)
  %16 = load i64, i64* %.omp.lb, align 8
  store i64 %16, i64* %.omp.iv, align 8
  br label %omp.inner.for.cond

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %omp.precond.then
  %17 = load i64, i64* %.omp.iv, align 8
  %18 = load i64, i64* %.capture_expr.7, align 8
  %add24 = add nsw i64 %18, 1
  %cmp25 = icmp slt i64 %17, %add24
  br i1 %cmp25, label %omp.inner.for.body, label %omp.inner.for.end

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %19 = load i32, i32* %.capture_expr., align 4
  %conv26 = sext i32 %19 to i64
  %20 = load i64, i64* %.omp.iv, align 8
  %div27 = sdiv i64 %20, 100
  %mul28 = mul nsw i64 %div27, 1
  %add29 = add nsw i64 %conv26, %mul28
  %conv30 = trunc i64 %add29 to i32
  store i32 %conv30, i32* %y, align 4
  %21 = load i64, i64* %.omp.iv, align 8
  %rem = srem i64 %21, 100
  %mul31 = mul nsw i64 %rem, 1
  %add32 = add nsw i64 0, %mul31
  %conv33 = trunc i64 %add32 to i32
  store i32 %conv33, i32* %x, align 4
  %22 = load i32, i32* %x, align 4
  %23 = load i32, i32* %y, align 4
  %add34 = add nsw i32 %22, %23
  %24 = load i32*, i32** %image22, align 8
  %25 = load i32, i32* %y, align 4
  %mul35 = mul nsw i32 %25, 100
  %26 = load i32, i32* %x, align 4
  %add36 = add nsw i32 %mul35, %26
  %idxprom = sext i32 %add36 to i64
  %arrayidx = getelementptr inbounds i32, i32* %24, i64 %idxprom
  store i32 %add34, i32* %arrayidx, align 4
  br label %omp.body.continue

omp.body.continue:                                ; preds = %omp.inner.for.body
  br label %omp.inner.for.inc

omp.inner.for.inc:                                ; preds = %omp.body.continue
  %27 = load i64, i64* %.omp.iv, align 8
  %add37 = add nsw i64 %27, 1
  store i64 %add37, i64* %.omp.iv, align 8
  %28 = load i64, i64* %.omp.lb, align 8
  %29 = load i64, i64* %.omp.stride, align 8
  %add38 = add nsw i64 %28, %29
  store i64 %add38, i64* %.omp.lb, align 8
  %30 = load i64, i64* %.omp.lb, align 8
  store i64 %30, i64* %.omp.iv, align 8
  br label %omp.inner.for.cond

omp.inner.for.end:                                ; preds = %omp.inner.for.cond
  br label %omp.loop.exit

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  %nvptx_block_id39 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !9
  %nvptx_num_threads40 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !range !10
  %num_workers41 = sub nuw i32 %nvptx_num_threads40, 32
  %31 = mul i32 %nvptx_block_id39, %num_workers41
  %nvptx_num_threads42 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !range !10
  %nvptx_warp_size43 = call i32 @llvm.nvvm.read.ptx.sreg.warpsize(), !range !11
  %32 = sub i32 %nvptx_warp_size43, 1
  %33 = sub i32 %nvptx_num_threads42, 1
  %34 = xor i32 %32, -1
  %master_tid44 = and i32 %33, %34
  %35 = sub nuw i32 %master_tid44, 1
  %nvptx_tid45 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !12
  %team_tid46 = and i32 %nvptx_tid45, %35
  %global_tid47 = add i32 %31, %team_tid46
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %global_tid47)
  br label %omp.precond.end

omp.precond.end:                                  ; preds = %omp.loop.exit, %entry
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #0

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.warpsize() #0

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

declare void @__kmpc_for_static_init_8_simple_spmd(%ident_t*, i32, i32, i32*, i64*, i64*, i64*, i64, i64)

declare void @__kmpc_for_static_fini(%ident_t*, i32)

; Function Attrs: noinline nounwind
define weak void @__omp_offloading_806_122265b_main_l16(i64 %start, i64 %end, i32* %image, i8* %scratchpad_ptr) #1 {
entry:
  %start.addr.i = alloca i64, align 8
  %end.addr.i = alloca i64, align 8
  %image.addr.i = alloca i32*, align 8
  %start.casted.i = alloca i64, align 8
  %end.casted.i = alloca i64, align 8
  %.threadid_temp..i = alloca i32, align 4
  %.zero.addr.i = alloca i32, align 4
  %start.addr = alloca i64, align 8
  %end.addr = alloca i64, align 8
  %image.addr = alloca i32*, align 8
  %scratchpad_ptr.addr = alloca i8*, align 8
  store i64 %start, i64* %start.addr, align 8
  store i64 %end, i64* %end.addr, align 8
  store i32* %image, i32** %image.addr, align 8
  store i8* %scratchpad_ptr, i8** %scratchpad_ptr.addr, align 8
  %0 = load i8*, i8** %scratchpad_ptr.addr, align 8
  call void @__kmpc_kernel_init_params(i8* %0)
  %1 = load i64, i64* %start.addr, align 8
  %2 = load i64, i64* %end.addr, align 8
  %3 = load i32*, i32** %image.addr, align 8
  store i32 0, i32* %.zero.addr.i, align 4
  store i64 %1, i64* %start.addr.i, align 8
  store i64 %2, i64* %end.addr.i, align 8
  store i32* %3, i32** %image.addr.i, align 8
  %conv.i = bitcast i64* %start.addr.i to i32*
  %conv1.i = bitcast i64* %end.addr.i to i32*
  %nvptx_num_threads.i = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #2, !range !10
  call void @__kmpc_spmd_kernel_init(i32 %nvptx_num_threads.i, i16 0, i16 0) #2
  %4 = load i32, i32* %conv.i, align 8
  %conv2.i = bitcast i64* %start.casted.i to i32*
  store i32 %4, i32* %conv2.i, align 4
  %5 = load i64, i64* %start.casted.i, align 8
  %6 = load i32, i32* %conv1.i, align 8
  %conv3.i = bitcast i64* %end.casted.i to i32*
  store i32 %6, i32* %conv3.i, align 4
  %7 = load i64, i64* %end.casted.i, align 8
  %8 = load i32*, i32** %image.addr.i, align 8
  %nvptx_block_id.i = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #2, !range !9
  %nvptx_num_threads4.i = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #2, !range !10
  %num_workers.i = sub nuw i32 %nvptx_num_threads4.i, 32
  %9 = mul i32 %nvptx_block_id.i, %num_workers.i
  %nvptx_num_threads5.i = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #2, !range !10
  %10 = sub i32 %nvptx_num_threads5.i, 1
  %master_tid.i = and i32 %10, -32
  %11 = sub nuw i32 %master_tid.i, 1
  %nvptx_tid.i = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #2, !range !12
  %team_tid.i = and i32 %nvptx_tid.i, %11
  %global_tid.i = add i32 %9, %team_tid.i
  store i32 %global_tid.i, i32* %.threadid_temp..i, align 4
  call void @.omp_outlined.(i32* %.threadid_temp..i, i32* %.zero.addr.i, i64 %5, i64 %7, i32* %8) #2
  ret void
}

declare void @__kmpc_kernel_init_params(i8*)

attributes #0 = { nounwind readnone }
attributes #1 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_50" "target-features"="+ptx60,-satom" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!omp_offload.info = !{!0}
!nvvm.annotations = !{!1, !2, !3, !2, !4, !4, !4, !4, !5, !5, !4}
!llvm.module.flags = !{!6}
!llvm.ident = !{!7}
!nvvm.internalize.after.link = !{}
!nvvmir.version = !{!8}

!0 = !{i32 0, i32 2054, i32 19015259, !"main", i32 16, i32 0}
!1 = !{void (i64, i64, i32*, i8*)* @__omp_offloading_806_122265b_main_l16, !"kernel", i32 1}
!2 = !{null, !"align", i32 8}
!3 = !{null, !"align", i32 8, !"align", i32 65544, !"align", i32 131080}
!4 = !{null, !"align", i32 16}
!5 = !{null, !"align", i32 16, !"align", i32 65552, !"align", i32 131088}
!6 = !{i32 1, !"PIC Level", i32 2}
!7 = !{!"clang version 4.0.0 "}
!8 = !{i32 1, i32 2}
!9 = !{i32 0, i32 2147483647}
!10 = !{i32 1, i32 1025}
!11 = !{i32 32, i32 33}
!12 = !{i32 0, i32 1024}

; __CLANG_OFFLOAD_BUNDLE____END__ openmp-nvptx64-nvidia-cuda

; __CLANG_OFFLOAD_BUNDLE____START__ host-x86_64-unknown-linux-gnu
; ModuleID = '/tmp/gpuoff-22a126.bc'
source_filename = "gpuoff.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct.__tgt_offload_entry = type { i8*, i8*, i8*, i64, i32, i32, i32 }
%struct.__tgt_device_image = type { i8*, i8*, %struct.__tgt_offload_entry*, %struct.__tgt_offload_entry* }
%struct.__tgt_bin_desc = type { i32, %struct.__tgt_device_image*, %struct.__tgt_offload_entry*, %struct.__tgt_offload_entry* }
%struct.anon = type { i32, i32, i32* }
%struct.kmp_depend_info = type { i64, i64, i8 }
%struct.kmp_task_t_with_privates = type { %struct.kmp_task_t, %struct..kmp_privates.t }
%struct.kmp_task_t = type { i8*, i32 (i32, i8*)*, i32, %union.kmp_cmplrdata_t, %union.kmp_cmplrdata_t, i32, i32, i32 }
%union.kmp_cmplrdata_t = type { i32 (i32, i8*)* }
%struct..kmp_privates.t = type { [3 x i8*], [3 x i8*], [3 x i64], i32*, i32, i32 }

$.omp_offloading.descriptor_reg = comdat any

@.offload_sizes = private unnamed_addr constant [1 x i64] [i64 40000]
@.offload_maptypes = private unnamed_addr constant [1 x i64] [i64 32]
@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2050, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@2 = private unnamed_addr constant %ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@__omp_offloading_806_122265b_main_l16.region_id = weak constant i8 0
@.offload_sizes.2 = private unnamed_addr constant [3 x i64] [i64 4, i64 4, i64 0]
@.offload_maptypes.3 = private unnamed_addr constant [3 x i64] [i64 800, i64 800, i64 544]
@.offload_maptypes.5 = private unnamed_addr constant [3 x i64] [i64 800, i64 800, i64 544]
@.offload_maptypes.6 = private unnamed_addr constant [1 x i64] [i64 34]
@.omp_offloading.entry_name = internal unnamed_addr constant [38 x i8] c"__omp_offloading_806_122265b_main_l16\00"
@.omp_offloading.entry_module = internal unnamed_addr constant [1 x i8] zeroinitializer
@.omp_offloading.entry.__omp_offloading_806_122265b_main_l16 = weak constant %struct.__tgt_offload_entry { i8* @__omp_offloading_806_122265b_main_l16.region_id, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.omp_offloading.entry_module, i32 0, i32 0), i64 0, i32 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
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
  %retval = alloca i32, align 4
  %num_blocks = alloca i32, align 4
  %block_size = alloca i32, align 4
  %image = alloca i32*, align 8
  %.offload_baseptrs = alloca [1 x i8*], align 8
  %.offload_ptrs = alloca [1 x i8*], align 8
  %block = alloca i32, align 4
  %start = alloca i32, align 4
  %end = alloca i32, align 4
  %start.casted = alloca i64, align 8
  %end.casted = alloca i64, align 8
  %tmp = alloca i32, align 4
  %tmp3 = alloca i32, align 4
  %.capture_expr. = alloca i32, align 4
  %.capture_expr.6 = alloca i32, align 4
  %.capture_expr.8 = alloca i64, align 8
  %.offload_baseptrs16 = alloca [3 x i8*], align 8
  %.offload_ptrs17 = alloca [3 x i8*], align 8
  %agg.captured = alloca %struct.anon, align 8
  %0 = call i32 @__kmpc_global_thread_num(%ident_t* @1)
  %.dep.arr.addr = alloca [1 x %struct.kmp_depend_info], align 8
  %.offload_baseptrs22 = alloca [1 x i8*], align 8
  %.offload_ptrs23 = alloca [1 x i8*], align 8
  %.offload_sizes = alloca [1 x i64], align 8
  %.dep.arr.addr24 = alloca [1 x %struct.kmp_depend_info], align 8
  store i32 0, i32* %retval, align 4
  store i32 1000, i32* %num_blocks, align 4
  store i32 10, i32* %block_size, align 4
  %call = call noalias i8* @malloc(i64 40000) #6
  %1 = bitcast i8* %call to i32*
  store i32* %1, i32** %image, align 8
  %2 = load i32*, i32** %image, align 8
  %3 = load i32*, i32** %image, align 8
  %arrayidx = getelementptr inbounds i32, i32* %3, i64 0
  %4 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs, i32 0, i32 0
  %5 = bitcast i8** %4 to i32**
  store i32* %2, i32** %5, align 8
  %6 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs, i32 0, i32 0
  %7 = bitcast i8** %6 to i32**
  store i32* %arrayidx, i32** %7, align 8
  %8 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs, i32 0, i32 0
  %9 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs, i32 0, i32 0
  call void @__tgt_target_data_begin(i64 -1, i32 1, i8** %8, i8** %9, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_sizes, i32 0, i32 0), i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes, i32 0, i32 0))
  store i32 0, i32* %block, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %10 = load i32, i32* %block, align 4
  %11 = load i32, i32* %num_blocks, align 4
  %cmp = icmp slt i32 %10, %11
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %12 = load i32, i32* %block, align 4
  %13 = load i32, i32* %num_blocks, align 4
  %div = sdiv i32 100, %13
  %mul = mul nsw i32 %12, %div
  store i32 %mul, i32* %start, align 4
  %14 = load i32, i32* %start, align 4
  %15 = load i32, i32* %num_blocks, align 4
  %div1 = sdiv i32 100, %15
  %add = add nsw i32 %14, %div1
  store i32 %add, i32* %end, align 4
  %16 = load i32, i32* %start, align 4
  %conv = bitcast i64* %start.casted to i32*
  store i32 %16, i32* %conv, align 4
  %17 = load i64, i64* %start.casted, align 8
  %18 = load i32, i32* %end, align 4
  %conv2 = bitcast i64* %end.casted to i32*
  store i32 %18, i32* %conv2, align 4
  %19 = load i64, i64* %end.casted, align 8
  %20 = load i32*, i32** %image, align 8
  %21 = load i32, i32* %start, align 4
  store i32 %21, i32* %.capture_expr., align 4
  %22 = load i32, i32* %end, align 4
  store i32 %22, i32* %.capture_expr.6, align 4
  %23 = load i32, i32* %.capture_expr.6, align 4
  %24 = load i32, i32* %.capture_expr., align 4
  %sub = sub nsw i32 %23, %24
  %sub9 = sub nsw i32 %sub, 1
  %add10 = add nsw i32 %sub9, 1
  %div11 = sdiv i32 %add10, 1
  %conv12 = sext i32 %div11 to i64
  %mul13 = mul nsw i64 %conv12, 100
  %sub14 = sub nsw i64 %mul13, 1
  store i64 %sub14, i64* %.capture_expr.8, align 8
  %25 = load i64, i64* %.capture_expr.8, align 8
  %add15 = add nsw i64 %25, 1
  call void @__kmpc_push_target_tripcount(i64 -1, i64 %add15)
  %26 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs16, i32 0, i32 0
  %27 = bitcast i8** %26 to i64*
  store i64 %17, i64* %27, align 8
  %28 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs17, i32 0, i32 0
  %29 = bitcast i8** %28 to i64*
  store i64 %17, i64* %29, align 8
  %30 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs16, i32 0, i32 1
  %31 = bitcast i8** %30 to i64*
  store i64 %19, i64* %31, align 8
  %32 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs17, i32 0, i32 1
  %33 = bitcast i8** %32 to i64*
  store i64 %19, i64* %33, align 8
  %34 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs16, i32 0, i32 2
  %35 = bitcast i8** %34 to i32**
  store i32* %20, i32** %35, align 8
  %36 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs17, i32 0, i32 2
  %37 = bitcast i8** %36 to i32**
  store i32* %20, i32** %37, align 8
  %38 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs16, i32 0, i32 0
  %39 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs17, i32 0, i32 0
  %40 = getelementptr inbounds %struct.anon, %struct.anon* %agg.captured, i32 0, i32 0
  %41 = load i32, i32* %start, align 4
  store i32 %41, i32* %40, align 8
  %42 = getelementptr inbounds %struct.anon, %struct.anon* %agg.captured, i32 0, i32 1
  %43 = load i32, i32* %end, align 4
  store i32 %43, i32* %42, align 4
  %44 = getelementptr inbounds %struct.anon, %struct.anon* %agg.captured, i32 0, i32 2
  %45 = load i32*, i32** %image, align 8
  store i32* %45, i32** %44, align 8
  %46 = call i8* @__kmpc_omp_target_task_alloc(%ident_t* @1, i32 %0, i32 1, i64 144, i64 16, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates*)* @.omp_task_entry. to i32 (i32, i8*)*), i64 -1, i32 3, i8** %38, i8** %39, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_sizes.2, i32 0, i32 0), i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_maptypes.3, i32 0, i32 0))
  %47 = bitcast i8* %46 to %struct.kmp_task_t_with_privates*
  %48 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %47, i32 0, i32 0
  %49 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %48, i32 0, i32 0
  %50 = load i8*, i8** %49, align 8
  %51 = bitcast %struct.anon* %agg.captured to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %50, i8* %51, i64 16, i32 8, i1 false)
  %52 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %47, i32 0, i32 1
  %53 = bitcast i8* %50 to %struct.anon*
  %54 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %52, i32 0, i32 0
  %55 = bitcast [3 x i8*]* %54 to i8*
  %56 = bitcast i8** %38 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %55, i8* %56, i64 24, i32 8, i1 false)
  %57 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %52, i32 0, i32 1
  %58 = bitcast [3 x i8*]* %57 to i8*
  %59 = bitcast i8** %39 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %58, i8* %59, i64 24, i32 8, i1 false)
  %60 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %52, i32 0, i32 2
  %61 = bitcast [3 x i64]* %60 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %61, i8* bitcast ([3 x i64]* @.offload_sizes.2 to i8*), i64 24, i32 8, i1 false)
  %62 = load i32*, i32** %image, align 8
  %63 = load i32, i32* %block, align 4
  %64 = load i32, i32* %block_size, align 4
  %mul18 = mul nsw i32 %63, %64
  %idxprom = sext i32 %mul18 to i64
  %arrayidx19 = getelementptr inbounds i32, i32* %62, i64 %idxprom
  %65 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr, i64 0, i64 0
  %66 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %65, i32 0, i32 0
  %67 = ptrtoint i32* %arrayidx19 to i64
  store i64 %67, i64* %66, align 8
  %68 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %65, i32 0, i32 1
  store i64 4, i64* %68, align 8
  %69 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %65, i32 0, i32 2
  store i8 3, i8* %69, align 8
  %70 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr, i32 0, i32 0
  %71 = bitcast %struct.kmp_depend_info* %70 to i8*
  %72 = call i32 @__kmpc_omp_task_with_deps(%ident_t* @1, i32 %0, i8* %46, i32 1, i8* %71, i32 0, i8* null)
  %73 = load i32*, i32** %image, align 8
  %74 = load i32, i32* %block, align 4
  %75 = load i32, i32* %block_size, align 4
  %mul20 = mul nsw i32 %74, %75
  %76 = sext i32 %mul20 to i64
  %77 = load i32*, i32** %image, align 8
  %arrayidx21 = getelementptr inbounds i32, i32* %77, i64 %76
  %78 = load i32, i32* %block_size, align 4
  %79 = zext i32 %78 to i64
  %80 = mul nuw i64 %79, 4
  %81 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs22, i32 0, i32 0
  %82 = bitcast i8** %81 to i32**
  store i32* %73, i32** %82, align 8
  %83 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs23, i32 0, i32 0
  %84 = bitcast i8** %83 to i32**
  store i32* %arrayidx21, i32** %84, align 8
  %85 = getelementptr inbounds [1 x i64], [1 x i64]* %.offload_sizes, i32 0, i32 0
  store i64 %80, i64* %85, align 8
  %86 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs22, i32 0, i32 0
  %87 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs23, i32 0, i32 0
  %88 = getelementptr inbounds [1 x i64], [1 x i64]* %.offload_sizes, i32 0, i32 0
  %89 = load i32*, i32** %image, align 8
  %90 = load i32, i32* %block, align 4
  %91 = load i32, i32* %block_size, align 4
  %mul25 = mul nsw i32 %90, %91
  %idxprom26 = sext i32 %mul25 to i64
  %arrayidx27 = getelementptr inbounds i32, i32* %89, i64 %idxprom26
  %92 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr24, i64 0, i64 0
  %93 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %92, i32 0, i32 0
  %94 = ptrtoint i32* %arrayidx27 to i64
  store i64 %94, i64* %93, align 8
  %95 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %92, i32 0, i32 1
  store i64 4, i64* %95, align 8
  %96 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %92, i32 0, i32 2
  store i8 3, i8* %96, align 8
  %97 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr24, i32 0, i32 0
  %98 = bitcast %struct.kmp_depend_info* %97 to i8*
  call void @__tgt_target_data_update_nowait_depend(i64 -1, i32 1, i8** %86, i8** %87, i64* %88, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes.6, i32 0, i32 0), i32 1, i8* %98, i32 0, i8* null)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %99 = load i32, i32* %block, align 4
  %inc = add nsw i32 %99, 1
  store i32 %inc, i32* %block, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %100 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_baseptrs, i32 0, i32 0
  %101 = getelementptr inbounds [1 x i8*], [1 x i8*]* %.offload_ptrs, i32 0, i32 0
  call void @__tgt_target_data_end(i64 -1, i32 1, i8** %100, i8** %101, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_sizes, i32 0, i32 0), i64* getelementptr inbounds ([1 x i64], [1 x i64]* @.offload_maptypes, i32 0, i32 0))
  %102 = call i32 @__kmpc_omp_taskwait(%ident_t* @1, i32 %0)
  %103 = load i32, i32* %retval, align 4
  ret i32 %103
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #1

declare void @__tgt_target_data_begin(i64, i32, i8**, i8**, i64*, i64*)

; Function Attrs: noinline nounwind uwtable
define internal void @__omp_offloading_806_122265b_main_l16(i64 %start, i64 %end, i32* %image) #2 {
entry:
  %start.addr = alloca i64, align 8
  %end.addr = alloca i64, align 8
  %image.addr = alloca i32*, align 8
  %start.casted = alloca i64, align 8
  %end.casted = alloca i64, align 8
  store i64 %start, i64* %start.addr, align 8
  store i64 %end, i64* %end.addr, align 8
  store i32* %image, i32** %image.addr, align 8
  %conv = bitcast i64* %start.addr to i32*
  %conv1 = bitcast i64* %end.addr to i32*
  %0 = load i32, i32* %conv, align 8
  %conv2 = bitcast i64* %start.casted to i32*
  store i32 %0, i32* %conv2, align 4
  %1 = load i64, i64* %start.casted, align 8
  %2 = load i32, i32* %conv1, align 8
  %conv3 = bitcast i64* %end.casted to i32*
  store i32 %2, i32* %conv3, align 4
  %3 = load i64, i64* %end.casted, align 8
  %4 = load i32*, i32** %image.addr, align 8
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_teams(%ident_t* @1, i32 3, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i64, i64, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*), i64 %1, i64 %3, i32* %4)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %start, i64 %end, i32* %image) #2 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %start.addr = alloca i64, align 8
  %end.addr = alloca i64, align 8
  %image.addr = alloca i32*, align 8
  %.omp.iv = alloca i64, align 8
  %tmp = alloca i32, align 4
  %tmp2 = alloca i32, align 4
  %.capture_expr. = alloca i32, align 4
  %.capture_expr.5 = alloca i32, align 4
  %.capture_expr.7 = alloca i64, align 8
  %y = alloca i32, align 4
  %x = alloca i32, align 4
  %.omp.lb = alloca i64, align 8
  %.omp.ub = alloca i64, align 8
  %.omp.stride = alloca i64, align 8
  %.omp.is_last = alloca i32, align 4
  %start18 = alloca i32, align 4
  %end20 = alloca i32, align 4
  %image22 = alloca i32*, align 8
  %0 = call i32 @__kmpc_global_thread_num(%ident_t* @1)
  %start.casted = alloca i64, align 8
  %end.casted = alloca i64, align 8
  store i32* %.global_tid., i32** %.global_tid..addr, align 8
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8
  store i64 %start, i64* %start.addr, align 8
  store i64 %end, i64* %end.addr, align 8
  store i32* %image, i32** %image.addr, align 8
  %conv = bitcast i64* %start.addr to i32*
  %conv1 = bitcast i64* %end.addr to i32*
  %1 = load i32, i32* %conv, align 8
  store i32 %1, i32* %.capture_expr., align 4
  %2 = load i32, i32* %conv1, align 8
  store i32 %2, i32* %.capture_expr.5, align 4
  %3 = load i32, i32* %.capture_expr.5, align 4
  %4 = load i32, i32* %.capture_expr., align 4
  %sub = sub nsw i32 %3, %4
  %sub8 = sub nsw i32 %sub, 1
  %add = add nsw i32 %sub8, 1
  %div = sdiv i32 %add, 1
  %conv9 = sext i32 %div to i64
  %mul = mul nsw i64 %conv9, 100
  %sub10 = sub nsw i64 %mul, 1
  store i64 %sub10, i64* %.capture_expr.7, align 8
  %5 = load i32, i32* %.capture_expr., align 4
  store i32 %5, i32* %y, align 4
  store i32 0, i32* %x, align 4
  %6 = load i32, i32* %.capture_expr., align 4
  %7 = load i32, i32* %.capture_expr.5, align 4
  %cmp = icmp slt i32 %6, %7
  br i1 %cmp, label %omp.precond.then, label %omp.precond.end

omp.precond.then:                                 ; preds = %entry
  store i64 0, i64* %.omp.lb, align 8
  %8 = load i64, i64* %.capture_expr.7, align 8
  store i64 %8, i64* %.omp.ub, align 8
  store i64 1, i64* %.omp.stride, align 8
  store i32 0, i32* %.omp.is_last, align 4
  %9 = load i32, i32* %conv, align 8
  store i32 %9, i32* %start18, align 4
  %10 = load i32, i32* %conv1, align 8
  store i32 %10, i32* %end20, align 4
  %11 = load i32*, i32** %image.addr, align 8
  store i32* %11, i32** %image22, align 8
  call void @__kmpc_for_static_init_8(%ident_t* @0, i32 %0, i32 92, i32* %.omp.is_last, i64* %.omp.lb, i64* %.omp.ub, i64* %.omp.stride, i64 1, i64 1)
  %12 = load i64, i64* %.omp.ub, align 8
  %13 = load i64, i64* %.capture_expr.7, align 8
  %cmp23 = icmp sgt i64 %12, %13
  br i1 %cmp23, label %cond.true, label %cond.false

cond.true:                                        ; preds = %omp.precond.then
  %14 = load i64, i64* %.capture_expr.7, align 8
  br label %cond.end

cond.false:                                       ; preds = %omp.precond.then
  %15 = load i64, i64* %.omp.ub, align 8
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i64 [ %14, %cond.true ], [ %15, %cond.false ]
  store i64 %cond, i64* %.omp.ub, align 8
  %16 = load i64, i64* %.omp.lb, align 8
  store i64 %16, i64* %.omp.iv, align 8
  br label %omp.inner.for.cond

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %17 = load i64, i64* %.omp.iv, align 8
  %18 = load i64, i64* %.omp.ub, align 8
  %cmp24 = icmp sle i64 %17, %18
  br i1 %cmp24, label %omp.inner.for.body, label %omp.inner.for.end

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %19 = load i64, i64* %.omp.lb, align 8
  %20 = load i64, i64* %.omp.ub, align 8
  %21 = load i32, i32* %start18, align 4
  %conv25 = bitcast i64* %start.casted to i32*
  store i32 %21, i32* %conv25, align 4
  %22 = load i64, i64* %start.casted, align 8
  %23 = load i32, i32* %end20, align 4
  %conv26 = bitcast i64* %end.casted to i32*
  store i32 %23, i32* %conv26, align 4
  %24 = load i64, i64* %end.casted, align 8
  %25 = load i32*, i32** %image22, align 8
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @1, i32 5, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i64, i64, i64, i64, i32*)* @.omp_outlined..1 to void (i32*, i32*, ...)*), i64 %19, i64 %20, i64 %22, i64 %24, i32* %25)
  br label %omp.inner.for.inc

omp.inner.for.inc:                                ; preds = %omp.inner.for.body
  %26 = load i64, i64* %.omp.iv, align 8
  %27 = load i64, i64* %.omp.stride, align 8
  %add27 = add nsw i64 %26, %27
  store i64 %add27, i64* %.omp.iv, align 8
  br label %omp.inner.for.cond

omp.inner.for.end:                                ; preds = %omp.inner.for.cond
  br label %omp.loop.exit

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %0)
  br label %omp.precond.end

omp.precond.end:                                  ; preds = %omp.loop.exit, %entry
  ret void
}

declare i32 @__kmpc_global_thread_num(%ident_t*)

declare void @__kmpc_for_static_init_8(%ident_t*, i32, i32, i32*, i64*, i64*, i64*, i64, i64)

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_outlined..1(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i64 %start, i64 %end, i32* %image) #2 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %.previous.lb..addr = alloca i64, align 8
  %.previous.ub..addr = alloca i64, align 8
  %start.addr = alloca i64, align 8
  %end.addr = alloca i64, align 8
  %image.addr = alloca i32*, align 8
  %.omp.iv = alloca i64, align 8
  %tmp = alloca i32, align 4
  %tmp2 = alloca i32, align 4
  %.capture_expr. = alloca i32, align 4
  %.capture_expr.5 = alloca i32, align 4
  %.capture_expr.7 = alloca i64, align 8
  %y = alloca i32, align 4
  %x = alloca i32, align 4
  %.omp.lb = alloca i64, align 8
  %.omp.ub = alloca i64, align 8
  %.omp.stride = alloca i64, align 8
  %.omp.is_last = alloca i32, align 4
  %start18 = alloca i32, align 4
  %end20 = alloca i32, align 4
  %image22 = alloca i32*, align 8
  %0 = call i32 @__kmpc_global_thread_num(%ident_t* @1)
  store i32* %.global_tid., i32** %.global_tid..addr, align 8
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8
  store i64 %.previous.lb., i64* %.previous.lb..addr, align 8
  store i64 %.previous.ub., i64* %.previous.ub..addr, align 8
  store i64 %start, i64* %start.addr, align 8
  store i64 %end, i64* %end.addr, align 8
  store i32* %image, i32** %image.addr, align 8
  %conv = bitcast i64* %start.addr to i32*
  %conv1 = bitcast i64* %end.addr to i32*
  %1 = load i32, i32* %conv, align 8
  store i32 %1, i32* %.capture_expr., align 4
  %2 = load i32, i32* %conv1, align 8
  store i32 %2, i32* %.capture_expr.5, align 4
  %3 = load i32, i32* %.capture_expr.5, align 4
  %4 = load i32, i32* %.capture_expr., align 4
  %sub = sub nsw i32 %3, %4
  %sub8 = sub nsw i32 %sub, 1
  %add = add nsw i32 %sub8, 1
  %div = sdiv i32 %add, 1
  %conv9 = sext i32 %div to i64
  %mul = mul nsw i64 %conv9, 100
  %sub10 = sub nsw i64 %mul, 1
  store i64 %sub10, i64* %.capture_expr.7, align 8
  %5 = load i32, i32* %.capture_expr., align 4
  store i32 %5, i32* %y, align 4
  store i32 0, i32* %x, align 4
  %6 = load i32, i32* %.capture_expr., align 4
  %7 = load i32, i32* %.capture_expr.5, align 4
  %cmp = icmp slt i32 %6, %7
  br i1 %cmp, label %omp.precond.then, label %omp.precond.end

omp.precond.then:                                 ; preds = %entry
  store i64 0, i64* %.omp.lb, align 8
  %8 = load i64, i64* %.capture_expr.7, align 8
  store i64 %8, i64* %.omp.ub, align 8
  store i64 1, i64* %.omp.stride, align 8
  store i32 0, i32* %.omp.is_last, align 4
  %9 = load i64, i64* %.previous.lb..addr, align 8
  %10 = load i64, i64* %.previous.ub..addr, align 8
  store i64 %9, i64* %.omp.lb, align 8
  store i64 %10, i64* %.omp.ub, align 8
  %11 = load i32, i32* %conv, align 8
  store i32 %11, i32* %start18, align 4
  %12 = load i32, i32* %conv1, align 8
  store i32 %12, i32* %end20, align 4
  %13 = load i32*, i32** %image.addr, align 8
  store i32* %13, i32** %image22, align 8
  call void @__kmpc_for_static_init_8(%ident_t* @2, i32 %0, i32 34, i32* %.omp.is_last, i64* %.omp.lb, i64* %.omp.ub, i64* %.omp.stride, i64 1, i64 1)
  %14 = load i64, i64* %.omp.ub, align 8
  %15 = load i64, i64* %.capture_expr.7, align 8
  %cmp23 = icmp sgt i64 %14, %15
  br i1 %cmp23, label %cond.true, label %cond.false

cond.true:                                        ; preds = %omp.precond.then
  %16 = load i64, i64* %.capture_expr.7, align 8
  br label %cond.end

cond.false:                                       ; preds = %omp.precond.then
  %17 = load i64, i64* %.omp.ub, align 8
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i64 [ %16, %cond.true ], [ %17, %cond.false ]
  store i64 %cond, i64* %.omp.ub, align 8
  %18 = load i64, i64* %.omp.lb, align 8
  store i64 %18, i64* %.omp.iv, align 8
  br label %omp.inner.for.cond

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %19 = load i64, i64* %.omp.iv, align 8
  %20 = load i64, i64* %.omp.ub, align 8
  %cmp24 = icmp sle i64 %19, %20
  br i1 %cmp24, label %omp.inner.for.body, label %omp.inner.for.end

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %21 = load i32, i32* %.capture_expr., align 4
  %conv25 = sext i32 %21 to i64
  %22 = load i64, i64* %.omp.iv, align 8
  %div26 = sdiv i64 %22, 100
  %mul27 = mul nsw i64 %div26, 1
  %add28 = add nsw i64 %conv25, %mul27
  %conv29 = trunc i64 %add28 to i32
  store i32 %conv29, i32* %y, align 4
  %23 = load i64, i64* %.omp.iv, align 8
  %rem = srem i64 %23, 100
  %mul30 = mul nsw i64 %rem, 1
  %add31 = add nsw i64 0, %mul30
  %conv32 = trunc i64 %add31 to i32
  store i32 %conv32, i32* %x, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32, i32* %y, align 4
  %add33 = add nsw i32 %24, %25
  %26 = load i32*, i32** %image22, align 8
  %27 = load i32, i32* %y, align 4
  %mul34 = mul nsw i32 %27, 100
  %28 = load i32, i32* %x, align 4
  %add35 = add nsw i32 %mul34, %28
  %idxprom = sext i32 %add35 to i64
  %arrayidx = getelementptr inbounds i32, i32* %26, i64 %idxprom
  store i32 %add33, i32* %arrayidx, align 4
  br label %omp.body.continue

omp.body.continue:                                ; preds = %omp.inner.for.body
  br label %omp.inner.for.inc

omp.inner.for.inc:                                ; preds = %omp.body.continue
  %29 = load i64, i64* %.omp.iv, align 8
  %add36 = add nsw i64 %29, 1
  store i64 %add36, i64* %.omp.iv, align 8
  br label %omp.inner.for.cond, !llvm.loop !2

omp.inner.for.end:                                ; preds = %omp.inner.for.cond
  br label %omp.loop.exit

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %0)
  %30 = load i32, i32* %.omp.is_last, align 4
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %.omp.final.then, label %.omp.final.done

.omp.final.then:                                  ; preds = %omp.loop.exit
  %32 = load i32, i32* %.capture_expr., align 4
  %33 = load i32, i32* %.capture_expr.5, align 4
  %34 = load i32, i32* %.capture_expr., align 4
  %sub37 = sub nsw i32 %33, %34
  %sub38 = sub nsw i32 %sub37, 1
  %add39 = add nsw i32 %sub38, 1
  %div40 = sdiv i32 %add39, 1
  %mul41 = mul nsw i32 %div40, 1
  %add42 = add nsw i32 %32, %mul41
  store i32 %add42, i32* %y, align 4
  store i32 100, i32* %x, align 4
  br label %.omp.final.done

.omp.final.done:                                  ; preds = %.omp.final.then, %omp.loop.exit
  br label %omp.precond.end

omp.precond.end:                                  ; preds = %.omp.final.done, %entry
  ret void
}

declare void @__kmpc_for_static_fini(%ident_t*, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

declare void @__kmpc_fork_teams(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

declare void @__kmpc_push_target_tripcount(i64, i64)

declare i32 @__tgt_target_teams_nowait(i64, i8*, i32, i8**, i8**, i64*, i64*, i32, i32, i8*)

; Function Attrs: alwaysinline uwtable
define internal void @.omp_task_privates_map.(%struct..kmp_privates.t* noalias, i32** noalias, i32** noalias, i32*** noalias, [3 x i8*]** noalias, [3 x i8*]** noalias, [3 x i64]** noalias) #3 {
entry:
  %.addr = alloca %struct..kmp_privates.t*, align 8
  %.addr1 = alloca i32**, align 8
  %.addr2 = alloca i32**, align 8
  %.addr3 = alloca i32***, align 8
  %.addr4 = alloca [3 x i8*]**, align 8
  %.addr5 = alloca [3 x i8*]**, align 8
  %.addr6 = alloca [3 x i64]**, align 8
  store %struct..kmp_privates.t* %0, %struct..kmp_privates.t** %.addr, align 8
  store i32** %1, i32*** %.addr1, align 8
  store i32** %2, i32*** %.addr2, align 8
  store i32*** %3, i32**** %.addr3, align 8
  store [3 x i8*]** %4, [3 x i8*]*** %.addr4, align 8
  store [3 x i8*]** %5, [3 x i8*]*** %.addr5, align 8
  store [3 x i64]** %6, [3 x i64]*** %.addr6, align 8
  %7 = load %struct..kmp_privates.t*, %struct..kmp_privates.t** %.addr, align 8
  %8 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %7, i32 0, i32 0
  %9 = load [3 x i8*]**, [3 x i8*]*** %.addr4, align 8
  store [3 x i8*]* %8, [3 x i8*]** %9, align 8
  %10 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %7, i32 0, i32 1
  %11 = load [3 x i8*]**, [3 x i8*]*** %.addr5, align 8
  store [3 x i8*]* %10, [3 x i8*]** %11, align 8
  %12 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %7, i32 0, i32 2
  %13 = load [3 x i64]**, [3 x i64]*** %.addr6, align 8
  store [3 x i64]* %12, [3 x i64]** %13, align 8
  %14 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %7, i32 0, i32 3
  %15 = load i32***, i32**** %.addr3, align 8
  store i32** %14, i32*** %15, align 8
  %16 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %7, i32 0, i32 4
  %17 = load i32**, i32*** %.addr1, align 8
  store i32* %16, i32** %17, align 8
  %18 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %7, i32 0, i32 5
  %19 = load i32**, i32*** %.addr2, align 8
  store i32* %18, i32** %19, align 8
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
  %.firstpriv.ptr.addr.i = alloca i32*, align 8
  %.firstpriv.ptr.addr1.i = alloca i32*, align 8
  %.firstpriv.ptr.addr2.i = alloca i32**, align 8
  %2 = alloca [3 x i8*]*, align 8
  %3 = alloca [3 x i8*]*, align 8
  %4 = alloca [3 x i64]*, align 8
  %start.casted.i = alloca i64, align 8
  %end.casted.i = alloca i64, align 8
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
  store void (i8*, ...)* bitcast (void (%struct..kmp_privates.t*, i32**, i32**, i32***, [3 x i8*]**, [3 x i8*]**, [3 x i64]**)* @.omp_task_privates_map. to void (i8*, ...)*), void (i8*, ...)** %.copy_fn..addr.i, align 8
  store i8* %14, i8** %.task_t..addr.i, align 8
  store %struct.anon* %11, %struct.anon** %__context.addr.i, align 8
  %15 = load %struct.anon*, %struct.anon** %__context.addr.i, align 8
  %16 = load void (i8*, ...)*, void (i8*, ...)** %.copy_fn..addr.i, align 8
  %17 = load i8*, i8** %.privates..addr.i, align 8
  call void (i8*, ...) %16(i8* %17, i32** %.firstpriv.ptr.addr.i, i32** %.firstpriv.ptr.addr1.i, i32*** %.firstpriv.ptr.addr2.i, [3 x i8*]** %2, [3 x i8*]** %3, [3 x i64]** %4) #6
  %18 = load i32*, i32** %.firstpriv.ptr.addr.i, align 8
  %19 = load i32*, i32** %.firstpriv.ptr.addr1.i, align 8
  %20 = load i32**, i32*** %.firstpriv.ptr.addr2.i, align 8
  %21 = load [3 x i8*]*, [3 x i8*]** %2, align 8
  %22 = load [3 x i8*]*, [3 x i8*]** %3, align 8
  %23 = load [3 x i64]*, [3 x i64]** %4, align 8
  %24 = getelementptr inbounds [3 x i8*], [3 x i8*]* %21, i64 0, i64 0
  %25 = getelementptr inbounds [3 x i8*], [3 x i8*]* %22, i64 0, i64 0
  %26 = getelementptr inbounds [3 x i64], [3 x i64]* %23, i64 0, i64 0
  %27 = call i32 @__tgt_target_teams_nowait(i64 -1, i8* @__omp_offloading_806_122265b_main_l16.region_id, i32 3, i8** %24, i8** %25, i64* %26, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_maptypes.5, i32 0, i32 0), i32 0, i32 0, i8* %14) #6
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %omp_offload.failed.i, label %.omp_outlined..4.exit

omp_offload.failed.i:                             ; preds = %entry
  %29 = load i32, i32* %18, align 4
  %conv.i = bitcast i64* %start.casted.i to i32*
  store i32 %29, i32* %conv.i, align 4
  %30 = load i64, i64* %start.casted.i, align 8
  %31 = load i32, i32* %19, align 4
  %conv3.i = bitcast i64* %end.casted.i to i32*
  store i32 %31, i32* %conv3.i, align 4
  %32 = load i64, i64* %end.casted.i, align 8
  %33 = load i32*, i32** %20, align 8
  call void @__omp_offloading_806_122265b_main_l16(i64 %30, i64 %32, i32* %33) #6
  br label %.omp_outlined..4.exit

.omp_outlined..4.exit:                            ; preds = %entry, %omp_offload.failed.i
  ret i32 0
}

declare i8* @__kmpc_omp_target_task_alloc(%ident_t*, i32, i32, i64, i64, i32 (i32, i8*)*, i64, i32, i8**, i8**, i64*, i64*)

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #5

declare i32 @__kmpc_omp_task_with_deps(%ident_t*, i32, i8*, i32, i8*, i32, i8*)

declare void @__tgt_target_data_update_nowait_depend(i64, i32, i8**, i8**, i64*, i64*, i32, i8*, i32, i8*)

declare void @__tgt_target_data_end(i64, i32, i8**, i8**, i64*, i64*)

declare i32 @__kmpc_omp_taskwait(%ident_t*, i32)

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
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { alwaysinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind }
attributes #6 = { nounwind }

!omp_offload.info = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 0, i32 2054, i32 19015259, !"main", i32 16, i32 0}
!1 = !{!"clang version 4.0.0 "}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.vectorize.enable", i1 true}

; __CLANG_OFFLOAD_BUNDLE____END__ host-x86_64-unknown-linux-gnu
