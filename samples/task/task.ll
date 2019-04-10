; ModuleID = 'task.cpp'
source_filename = "task.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct.anon = type { i32* }
%struct.kmp_depend_info = type { i64, i64, i8 }
%struct.anon.0 = type { i32* }
%struct.kmp_task_t_with_privates = type { %struct.kmp_task_t }
%struct.kmp_task_t = type { i8*, i32 (i32, i8*)*, i32, %union.kmp_cmplrdata_t, %union.kmp_cmplrdata_t, i32, i32, i32 }
%union.kmp_cmplrdata_t = type { i32 (i32, i8*)* }
%struct.kmp_task_t_with_privates.1 = type { %struct.kmp_task_t }

@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant %ident_t { i32 0, i32 322, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@.str.4 = private unnamed_addr constant [13 x i8] c"result:  %d\0A\00", align 1

; Function Attrs: noinline norecurse uwtable
define i32 @main() #0 {
entry:
  %A = alloca i32, align 4
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 1, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*), i32* %A)
  %0 = load i32, i32* %A, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i32 0, i32 0), i32 %0)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i32* dereferenceable(4) %A) #1 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %A.addr = alloca i32*, align 8
  %agg.captured = alloca %struct.anon, align 8
  %.dep.arr.addr = alloca [1 x %struct.kmp_depend_info], align 8
  %agg.captured1 = alloca %struct.anon.0, align 8
  %.dep.arr.addr2 = alloca [1 x %struct.kmp_depend_info], align 8
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
  %5 = getelementptr inbounds %struct.anon, %struct.anon* %agg.captured, i32 0, i32 0
  store i32* %0, i32** %5, align 8
  %6 = call i8* @__kmpc_omp_task_alloc(%ident_t* @0, i32 %2, i32 1, i64 56, i64 8, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates*)* @.omp_task_entry. to i32 (i32, i8*)*), i32 0, i32 0)
  %7 = bitcast i8* %6 to %struct.kmp_task_t_with_privates*
  %8 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %7, i32 0, i32 0
  %9 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %8, i32 0, i32 0
  %10 = load i8*, i8** %9, align 8
  %11 = bitcast %struct.anon* %agg.captured to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %10, i8* %11, i64 8, i32 8, i1 false)
  %12 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr, i64 0, i64 0
  %13 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %12, i32 0, i32 0
  %14 = ptrtoint i32* %0 to i64
  store i64 %14, i64* %13, align 8
  %15 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %12, i32 0, i32 1
  store i64 4, i64* %15, align 8
  %16 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %12, i32 0, i32 2
  store i8 3, i8* %16, align 8
  %17 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr, i32 0, i32 0
  %18 = bitcast %struct.kmp_depend_info* %17 to i8*
  %19 = call i32 @__kmpc_omp_task_with_deps(%ident_t* @0, i32 %2, i8* %6, i32 1, i8* %18, i32 0, i8* null)
  %20 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %agg.captured1, i32 0, i32 0
  store i32* %0, i32** %20, align 8
  %21 = call i8* @__kmpc_omp_task_alloc(%ident_t* @0, i32 %2, i32 1, i64 56, i64 8, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates.1*)* @.omp_task_entry..3 to i32 (i32, i8*)*), i32 0, i32 0)
  %22 = bitcast i8* %21 to %struct.kmp_task_t_with_privates.1*
  %23 = getelementptr inbounds %struct.kmp_task_t_with_privates.1, %struct.kmp_task_t_with_privates.1* %22, i32 0, i32 0
  %24 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %23, i32 0, i32 0
  %25 = load i8*, i8** %24, align 8
  %26 = bitcast %struct.anon.0* %agg.captured1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %25, i8* %26, i64 8, i32 8, i1 false)
  %27 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr2, i64 0, i64 0
  %28 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %27, i32 0, i32 0
  %29 = ptrtoint i32* %0 to i64
  store i64 %29, i64* %28, align 8
  %30 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %27, i32 0, i32 1
  store i64 4, i64* %30, align 8
  %31 = getelementptr inbounds %struct.kmp_depend_info, %struct.kmp_depend_info* %27, i32 0, i32 2
  store i8 1, i8* %31, align 8
  %32 = getelementptr inbounds [1 x %struct.kmp_depend_info], [1 x %struct.kmp_depend_info]* %.dep.arr.addr2, i32 0, i32 0
  %33 = bitcast %struct.kmp_depend_info* %32 to i8*
  %34 = call i32 @__kmpc_omp_task_with_deps(%ident_t* @0, i32 %2, i8* %21, i32 1, i8* %33, i32 0, i8* null)
  call void @__kmpc_end_single(%ident_t* @0, i32 %2)
  br label %omp_if.end

omp_if.end:                                       ; preds = %omp_if.then, %entry
  call void @__kmpc_barrier(%ident_t* @1, i32 %2)
  ret void
}

declare i32 @__kmpc_single(%ident_t*, i32)

declare void @__kmpc_end_single(%ident_t*, i32)

; Function Attrs: noinline uwtable
define internal i32 @.omp_task_entry.(i32, %struct.kmp_task_t_with_privates* noalias) #2 {
entry:
  %.global_tid..addr.i = alloca i32, align 4
  %.part_id..addr.i = alloca i32*, align 8
  %.privates..addr.i = alloca i8*, align 8
  %.copy_fn..addr.i = alloca void (i8*, ...)*, align 8
  %.task_t..addr.i = alloca i8*, align 8
  %__context.addr.i = alloca %struct.anon*, align 8
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
  %11 = getelementptr inbounds %struct.anon, %struct.anon* %10, i32 0, i32 0
  %ref.i = load i32*, i32** %11, align 8
  store i32 10, i32* %ref.i, align 4
  ret i32 0
}

declare i8* @__kmpc_omp_task_alloc(%ident_t*, i32, i32, i64, i64, i32 (i32, i8*)*, i32, i32)

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

declare i32 @__kmpc_omp_task_with_deps(%ident_t*, i32, i8*, i32, i8*, i32, i8*)

; Function Attrs: noinline uwtable
define internal i32 @.omp_task_entry..3(i32, %struct.kmp_task_t_with_privates.1* noalias) #2 {
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
  %ref.i = load i32*, i32** %11, align 8
  %12 = load i32, i32* %ref.i, align 4
  %add.i = add nsw i32 %12, 100
  store i32 %add.i, i32* %ref.i, align 4
  ret i32 0
}

declare void @__kmpc_barrier(%ident_t*, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

declare i32 @printf(i8*, ...) #4

attributes #0 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 "}
