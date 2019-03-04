
; __CLANG_OFFLOAD_BUNDLE____START__ openmp-nvptx64-nvidia-cuda
; ModuleID = 'tsk.cpp'
source_filename = "tsk.cpp"
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}
!nvvm.internalize.after.link = !{}
!nvvmir.version = !{!2}
!nvvm.annotations = !{!3, !4, !3, !5, !5, !5, !5, !6, !6, !5}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 4.0.0 "}
!2 = !{i32 1, i32 2}
!3 = !{null, !"align", i32 8}
!4 = !{null, !"align", i32 8, !"align", i32 65544, !"align", i32 131080}
!5 = !{null, !"align", i32 16}
!6 = !{null, !"align", i32 16, !"align", i32 65552, !"align", i32 131088}

; __CLANG_OFFLOAD_BUNDLE____END__ openmp-nvptx64-nvidia-cuda

; __CLANG_OFFLOAD_BUNDLE____START__ openmp-x86_64-unknown-linux-gnu
; ModuleID = 'tsk.cpp'
source_filename = "tsk.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 4.0.0 "}

; __CLANG_OFFLOAD_BUNDLE____END__ openmp-x86_64-unknown-linux-gnu

; __CLANG_OFFLOAD_BUNDLE____START__ host-x86_64-unknown-linux-gnu
; ModuleID = '/tmp/tsk-62039d.bc'
source_filename = "tsk.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct.anon = type { [2 x i32]* }
%struct.kmp_depend_info = type { i64, i64, i8 }
%struct.anon.0 = type { [2 x i32]* }
%struct.kmp_task_t_with_privates = type { %struct.kmp_task_t }
%struct.kmp_task_t = type { i8*, i32 (i32, i8*)*, i32, %union.kmp_cmplrdata_t, %union.kmp_cmplrdata_t, i32, i32 }
%union.kmp_cmplrdata_t = type { i32 (i32, i8*)* }
%struct.kmp_task_t_with_privates.1 = type { %struct.kmp_task_t }

$__clang_call_terminate = comdat any

@_ZZ4mainE1A = private unnamed_addr constant [2 x i32] [i32 1, i32 2], align 4
@.str = private unnamed_addr constant [17 x i8] c"I am thread %d.\0A\00", align 1
@.str.1 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@.str.5 = private unnamed_addr constant [25 x i8] c"\0A\0ANumber of threads %d\0A\0A\00", align 1
@1 = private unnamed_addr constant %ident_t { i32 0, i32 322, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@.str.6 = private unnamed_addr constant [16 x i8] c"result:  %d %d\0A\00", align 1

; Function Attrs: noinline norecurse uwtable
define i32 @main() #0 {
entry:
  %A = alloca [2 x i32], align 4
  %0 = bitcast [2 x i32]* %A to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* bitcast ([2 x i32]* @_ZZ4mainE1A to i8*), i64 8, i32 4, i1 false)
  call void @omp_set_num_threads(i32 4)
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 1, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, [2 x i32]*)* @.omp_outlined. to void (i32*, i32*, ...)*), [2 x i32]* %A)
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %A, i64 0, i64 0
  %1 = load i32, i32* %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds [2 x i32], [2 x i32]* %A, i64 0, i64 1
  %2 = load i32, i32* %arrayidx1, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i32 0, i32 0), i32 %1, i32 %2)
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
  %agg.captured = alloca %struct.anon, align 8
  %.dep.arr.addr = alloca [1 x %struct.kmp_depend_info], align 8
  %agg.captured4 = alloca %struct.anon.0, align 8
  %.dep.arr.addr5 = alloca [1 x %struct.kmp_depend_info], align 8
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
  %4 = getelementptr inbounds %struct.anon, %struct.anon* %agg.captured, i32 0, i32 0
  store [2 x i32]* %1, [2 x i32]** %4, align 8
  %5 = call i8* @__kmpc_omp_task_alloc(%ident_t* @0, i32 %0, i32 1, i64 48, i64 8, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates*)* @.omp_task_entry. to i32 (i32, i8*)*), i32 0, i32 0)
  %6 = bitcast i8* %5 to %struct.kmp_task_t_with_privates*
  %7 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %6, i32 0, i32 0
  %8 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %7, i32 0, i32 0
  %9 = load i8*, i8** %8, align 8
  %10 = bitcast %struct.anon* %agg.captured to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %9, i8* %10, i64 8, i32 8, i1 false)
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 0
  %arrayidx3 = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 1
  %11 = getelementptr i32, i32* %arrayidx3, i32 1
  %12 = ptrtoint i32* %arrayidx to i64
  %13 = ptrtoint i32* %11 to i64
  %14 = sub nuw i64 %13, %12
  %15 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr, i64 0, i64 0
  %16 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %15, i32 0, i32 0
  %17 = ptrtoint i32* %arrayidx to i64
  store i64 %17, i64* %16, align 8
  %18 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %15, i32 0, i32 1
  store i64 %14, i64* %18, align 8
  %19 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %15, i32 0, i32 2
  store i8 3, i8* %19, align 8
  %20 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr, i32 0, i32 0
  %21 = bitcast %struct.kmp_depend_info* %20 to i8*
  %22 = call i32 @__kmpc_omp_task_with_deps(%ident_t* @0, i32 %0, i8* %5, i32 1, i8* %21, i32 0, i8* null)
  %23 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %agg.captured4, i32 0, i32 0
  store [2 x i32]* %1, [2 x i32]** %23, align 8
  %24 = call i8* @__kmpc_omp_task_alloc(%ident_t* @0, i32 %0, i32 1, i64 48, i64 8, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates.1*)* @.omp_task_entry..4 to i32 (i32, i8*)*), i32 0, i32 0)
  %25 = bitcast i8* %24 to %struct.kmp_task_t_with_privates.1*
  %26 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %25, i32 0, i32 0
  %27 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %26, i32 0, i32 0
  %28 = load i8*, i8** %27, align 8
  %29 = bitcast %struct.anon.0* %agg.captured4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %28, i8* %29, i64 8, i32 8, i1 false)
  %arrayidx6 = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 0
  %arrayidx7 = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 1
  %30 = getelementptr i32, i32* %arrayidx7, i32 1
  %31 = ptrtoint i32* %arrayidx6 to i64
  %32 = ptrtoint i32* %30 to i64
  %33 = sub nuw i64 %32, %31
  %34 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr5, i64 0, i64 0
  %35 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %34, i32 0, i32 0
  %36 = ptrtoint i32* %arrayidx6 to i64
  store i64 %36, i64* %35, align 8
  %37 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %34, i32 0, i32 1
  store i64 %33, i64* %37, align 8
  %38 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %34, i32 0, i32 2
  store i8 1, i8* %38, align 8
  %39 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr5, i32 0, i32 0
  %40 = bitcast %struct.kmp_depend_info* %39 to i8*
  %41 = call i32 @__kmpc_omp_task_with_deps(%ident_t* @0, i32 %0, i8* %24, i32 1, i8* %40, i32 0, i8* null)
  %call9 = invoke i32 @omp_get_num_threads()
          to label %invoke.cont8 unwind label %lpad

invoke.cont8:                                     ; preds = %omp_if.then
  %call11 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.5, i32 0, i32 0), i32 %call9)
          to label %invoke.cont10 unwind label %lpad

invoke.cont10:                                    ; preds = %invoke.cont8
  call void @__kmpc_end_single(%ident_t* @0, i32 %0)
  br label %omp_if.end

lpad:                                             ; preds = %invoke.cont8, %omp_if.then
  %42 = landingpad { i8*, i32 }
          catch i8* null
  %43 = extractvalue { i8*, i32 } %42, 0
  store i8* %43, i8** %exn.slot, align 8
  %44 = extractvalue { i8*, i32 } %42, 1
  store i32 %44, i32* %ehselector.slot, align 4
  call void @__kmpc_end_single(%ident_t* @0, i32 %0)
  br label %terminate.handler

omp_if.end:                                       ; preds = %invoke.cont10, %invoke.cont1
  call void @__kmpc_barrier(%ident_t* @1, i32 %0)
  ret void

terminate.lpad:                                   ; preds = %invoke.cont, %entry
  %45 = landingpad { i8*, i32 }
          catch i8* null
  %46 = extractvalue { i8*, i32 } %45, 0
  call void @__clang_call_terminate(i8* %46) #6
  unreachable

terminate.handler:                                ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  call void @__clang_call_terminate(i8* %exn) #6
  unreachable
}

declare i32 @printf(i8*, ...) #2

declare i32 @omp_get_thread_num() #2

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #4 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #7
  call void @_ZSt9terminatev() #6
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

declare i32 @__kmpc_global_thread_num(%ident_t*)

declare i32 @__kmpc_single(%ident_t*, i32)

declare void @__kmpc_end_single(%ident_t*, i32)

; Function Attrs: noinline uwtable
define internal i32 @.omp_task_entry.(i32, %struct.kmp_task_t_with_privates* noalias) #5 {
entry:
  %.global_tid..addr.i = alloca i32, align 4
  %.part_id..addr.i = alloca i32*, align 8
  %.privates..addr.i = alloca i8*, align 8
  %.copy_fn..addr.i = alloca void (i8*, ...)*, align 8
  %.task_t..addr.i = alloca i8*, align 8
  %__context.addr.i = alloca %struct.anon*, align 8
  %i.i = alloca i32, align 4
  %j.i = alloca i32, align 4
  %.addr = alloca i32, align 4
  %.addr1 = alloca %struct.kmp_task_t_with_privates*, align 8
  store i32 %0, i32* %.addr, align 4
  store %struct.kmp_task_t_with_privates* %1, %struct.kmp_task_t_with_privates** %.addr1, align 8
  %2 = load i32, i32* %.addr, align 4
  %3 = load %struct.kmp_task_t_with_privates*, %struct.kmp_task_t_with_privates** %.addr1, align 8
  %4 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %4, i32 0, i32 2
  %6 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %4, i32 0, i32 0
  %7 = load i8*, i8** %6, align 8
  %8 = bitcast i8* %7 to %struct.anon*
  %9 = bitcast %struct.kmp_task_t_with_privates* %3 to i8*
  store i32 %2, i32* %.global_tid..addr.i, align 4
  store i32* %5, i32** %.part_id..addr.i, align 8
  store i8* null, i8** %.privates..addr.i, align 8
  store void (i8*, ...)* null, void (i8*, ...)** %.copy_fn..addr.i, align 8
  store i8* %9, i8** %.task_t..addr.i, align 8
  store %struct.anon* %8, %struct.anon** %__context.addr.i, align 8
  %10 = load %struct.anon*, %struct.anon** %__context.addr.i, align 8
  store i32 0, i32* %i.i, align 4
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.end.i, %entry
  %11 = load i32, i32* %i.i, align 4
  %cmp.i = icmp slt i32 %11, 99999
  br i1 %cmp.i, label %for.body.i, label %.omp_outlined..2.exit

for.body.i:                                       ; preds = %for.cond.i
  store i32 0, i32* %j.i, align 4
  br label %for.cond1.i

for.cond1.i:                                      ; preds = %for.body3.i, %for.body.i
  %12 = load i32, i32* %j.i, align 4
  %cmp2.i = icmp slt i32 %12, 99999
  br i1 %cmp2.i, label %for.body3.i, label %for.end.i

for.body3.i:                                      ; preds = %for.cond1.i
  %13 = getelementptr inbounds %struct.anon, %struct.anon* %10, i32 0, i32 0
  %ref.i = load [2 x i32]*, [2 x i32]** %13, align 8
  %arrayidx.i = getelementptr inbounds [2 x i32], [2 x i32]* %ref.i, i64 0, i64 0
  store i32 10, i32* %arrayidx.i, align 4
  %14 = load i32, i32* %j.i, align 4
  %inc.i = add nsw i32 %14, 1
  store i32 %inc.i, i32* %j.i, align 4
  br label %for.cond1.i

for.end.i:                                        ; preds = %for.cond1.i
  %15 = load i32, i32* %i.i, align 4
  %inc5.i = add nsw i32 %15, 1
  store i32 %inc5.i, i32* %i.i, align 4
  br label %for.cond.i

.omp_outlined..2.exit:                            ; preds = %for.cond.i
  %16 = getelementptr inbounds %struct.anon, %struct.anon* %10, i32 0, i32 0
  %ref7.i = load [2 x i32]*, [2 x i32]** %16, align 8
  %arrayidx8.i = getelementptr inbounds [2 x i32], [2 x i32]* %ref7.i, i64 0, i64 1
  store i32 10, i32* %arrayidx8.i, align 4
  ret i32 0
}

declare i8* @__kmpc_omp_task_alloc(%ident_t*, i32, i32, i64, i64, i32 (i32, i8*)*, i32, i32)

declare i32 @__kmpc_omp_task_with_deps(%ident_t*, i32, i8*, i32, i8*, i32, i8*)

; Function Attrs: noinline uwtable
define internal i32 @.omp_task_entry..4(i32, %struct.kmp_task_t_with_privates.1* noalias) #5 {
entry:
  %.global_tid..addr.i = alloca i32, align 4
  %.part_id..addr.i = alloca i32*, align 8
  %.privates..addr.i = alloca i8*, align 8
  %.copy_fn..addr.i = alloca void (i8*, ...)*, align 8
  %.task_t..addr.i = alloca i8*, align 8
  %__context.addr.i = alloca %struct.anon.0*, align 8
  %.addr = alloca i32, align 4
  %.addr1 = alloca %struct.kmp_task_t_with_privates.1*, align 8
  store i32 %0, i32* %.addr, align 4
  store %struct.kmp_task_t_with_privates.1* %1, %struct.kmp_task_t_with_privates.1** %.addr1, align 8
  %2 = load i32, i32* %.addr, align 4
  %3 = load %struct.kmp_task_t_with_privates.1*, %struct.kmp_task_t_with_privates.1** %.addr1, align 8
  %4 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %4, i32 0, i32 2
  %6 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %4, i32 0, i32 0
  %7 = load i8*, i8** %6, align 8
  %8 = bitcast i8* %7 to %struct.anon.0*
  %9 = bitcast %struct.kmp_task_t_with_privates.1* %3 to i8*
  store i32 %2, i32* %.global_tid..addr.i, align 4
  store i32* %5, i32** %.part_id..addr.i, align 8
  store i8* null, i8** %.privates..addr.i, align 8
  store void (i8*, ...)* null, void (i8*, ...)** %.copy_fn..addr.i, align 8
  store i8* %9, i8** %.task_t..addr.i, align 8
  store %struct.anon.0* %8, %struct.anon.0** %__context.addr.i, align 8
  %10 = load %struct.anon.0*, %struct.anon.0** %__context.addr.i, align 8
  %11 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %10, i32 0, i32 0
  %ref.i = load [2 x i32]*, [2 x i32]** %11, align 8
  %arrayidx.i = getelementptr inbounds [2 x i32], [2 x i32]* %ref.i, i64 0, i64 0
  %12 = load i32, i32* %arrayidx.i, align 4
  %add.i = add nsw i32 %12, 100
  store i32 %add.i, i32* %arrayidx.i, align 4
  %13 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %10, i32 0, i32 0
  %ref1.i = load [2 x i32]*, [2 x i32]** %13, align 8
  %arrayidx2.i = getelementptr inbounds [2 x i32], [2 x i32]* %ref1.i, i64 0, i64 1
  %14 = load i32, i32* %arrayidx2.i, align 4
  %add3.i = add nsw i32 %14, 100
  store i32 %add3.i, i32* %arrayidx2.i, align 4
  ret i32 0
}

declare i32 @omp_get_num_threads() #2

declare void @__kmpc_barrier(%ident_t*, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

attributes #0 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline noreturn nounwind }
attributes #5 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 "}

; __CLANG_OFFLOAD_BUNDLE____END__ host-x86_64-unknown-linux-gnu
