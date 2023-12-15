; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none)
define internal i64 @opt_ex.aocloop_do_work_1(ptr noalias nocapture nonnull readnone %__.context_ptr) #7 {
decls:
  %0 = load i64, ptr @opt_ex.big_grid_1.1, align 8
  %1 = icmp sgt i64 %0, 0
  br i1 %1, label %for.index.body.lr.ph, label %for.index.done

for.index.body.lr.ph:                             ; preds = %decls
  %2 = load i64, ptr @opt_ex.grid_width, align 8
  %xtraiter = and i64 %0, 7
  %3 = icmp ult i64 %0, 8
  br i1 %3, label %for.index.done.loopexit.unr-lcssa, label %for.index.body.lr.ph.new

for.index.body.lr.ph.new:                         ; preds = %for.index.body.lr.ph
  %unroll_iter = and i64 %0, -8
  %4 = load ptr, ptr @opt_ex.big_grid_1.0, align 8
  %5 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %6 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %7 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %8 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %9 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %10 = load ptr, ptr @opt_ex.big_grid_1.0, align 8
  %11 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %12 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %13 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %14 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %15 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %16 = load ptr, ptr @opt_ex.big_grid_1.0, align 8
  %17 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %18 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %19 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %20 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %21 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %22 = load ptr, ptr @opt_ex.big_grid_1.0, align 8
  %23 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %24 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %25 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %26 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %27 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %28 = load ptr, ptr @opt_ex.big_grid_1.0, align 8
  %29 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %30 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %31 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %32 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %33 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %34 = load ptr, ptr @opt_ex.big_grid_1.0, align 8
  %35 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %36 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %37 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %38 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %39 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %40 = load ptr, ptr @opt_ex.big_grid_1.0, align 8
  %41 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %42 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %43 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %44 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %45 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %46 = load ptr, ptr @opt_ex.big_grid_1.0, align 8
  %47 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %48 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %49 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %50 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %51 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  br label %for.index.body

for.index.body:                                   ; preds = %switch.done.7, %for.index.body.lr.ph.new
  %52 = phi i64 [ 0, %for.index.body.lr.ph.new ], [ %236, %switch.done.7 ]
  %result.03 = phi i64 [ 0, %for.index.body.lr.ph.new ], [ %result.1.7, %switch.done.7 ]
  %niter = phi i64 [ 0, %for.index.body.lr.ph.new ], [ %niter.next.7, %switch.done.7 ]
  %53 = getelementptr i8, ptr %4, i64 %52
  %54 = load i8, ptr %53, align 1
  %55 = sdiv i64 %52, %2
  %56 = srem i64 %52, %2
  switch i8 %54, label %switch.done [
    i8 79, label %switch.case.body
    i8 35, label %switch.case.body1
  ]

switch.case.body:                                 ; preds = %for.index.body
  %57 = getelementptr i64, ptr %7, i64 %56
  %58 = load i64, ptr %57, align 8
  %59 = xor i64 %58, -1
  %60 = add nuw i64 %56, 1
  %61 = mul i64 %60, %2
  %62 = add i64 %61, %59
  %63 = getelementptr i8, ptr %8, i64 %62
  store i8 79, ptr %63, align 1
  %64 = getelementptr i64, ptr %9, i64 %56
  %65 = load i64, ptr %64, align 8
  %66 = add i64 %65, 1
  store i64 %66, ptr %64, align 8
  %67 = add i64 %55, %result.03
  br label %switch.done

switch.case.body1:                                ; preds = %for.index.body
  %68 = mul i64 %56, %2
  %69 = xor i64 %55, -1
  %70 = add i64 %2, %69
  %71 = add i64 %70, %68
  %72 = getelementptr i8, ptr %5, i64 %71
  store i8 35, ptr %72, align 1
  %73 = getelementptr i64, ptr %6, i64 %56
  %74 = add i64 %55, 1
  store i64 %74, ptr %73, align 8
  br label %switch.done

switch.done:                                      ; preds = %switch.case.body1, %switch.case.body, %for.index.body
  %result.1 = phi i64 [ %result.03, %for.index.body ], [ %result.03, %switch.case.body1 ], [ %67, %switch.case.body ]
  %75 = or i64 %52, 1
  %76 = getelementptr i8, ptr %10, i64 %75
  %77 = load i8, ptr %76, align 1
  %78 = sdiv i64 %75, %2
  %79 = srem i64 %75, %2
  switch i8 %77, label %switch.done.1 [
    i8 79, label %switch.case.body.1
    i8 35, label %switch.case.body1.1
  ]

switch.case.body1.1:                              ; preds = %switch.done
  %80 = mul i64 %79, %2
  %81 = xor i64 %78, -1
  %82 = add i64 %2, %81
  %83 = add i64 %82, %80
  %84 = getelementptr i8, ptr %11, i64 %83
  store i8 35, ptr %84, align 1
  %85 = getelementptr i64, ptr %12, i64 %79
  %86 = add i64 %78, 1
  store i64 %86, ptr %85, align 8
  br label %switch.done.1

switch.case.body.1:                               ; preds = %switch.done
  %87 = getelementptr i64, ptr %13, i64 %79
  %88 = load i64, ptr %87, align 8
  %89 = xor i64 %88, -1
  %90 = add nuw i64 %79, 1
  %91 = mul i64 %90, %2
  %92 = add i64 %91, %89
  %93 = getelementptr i8, ptr %14, i64 %92
  store i8 79, ptr %93, align 1
  %94 = getelementptr i64, ptr %15, i64 %79
  %95 = load i64, ptr %94, align 8
  %96 = add i64 %95, 1
  store i64 %96, ptr %94, align 8
  %97 = add i64 %78, %result.1
  br label %switch.done.1

switch.done.1:                                    ; preds = %switch.case.body.1, %switch.case.body1.1, %switch.done
  %result.1.1 = phi i64 [ %result.1, %switch.done ], [ %result.1, %switch.case.body1.1 ], [ %97, %switch.case.body.1 ]
  %98 = or i64 %52, 2
  %99 = getelementptr i8, ptr %16, i64 %98
  %100 = load i8, ptr %99, align 1
  %101 = sdiv i64 %98, %2
  %102 = srem i64 %98, %2
  switch i8 %100, label %switch.done.2 [
    i8 79, label %switch.case.body.2
    i8 35, label %switch.case.body1.2
  ]

switch.case.body1.2:                              ; preds = %switch.done.1
  %103 = mul i64 %102, %2
  %104 = xor i64 %101, -1
  %105 = add i64 %2, %104
  %106 = add i64 %105, %103
  %107 = getelementptr i8, ptr %17, i64 %106
  store i8 35, ptr %107, align 1
  %108 = getelementptr i64, ptr %18, i64 %102
  %109 = add i64 %101, 1
  store i64 %109, ptr %108, align 8
  br label %switch.done.2

switch.case.body.2:                               ; preds = %switch.done.1
  %110 = getelementptr i64, ptr %19, i64 %102
  %111 = load i64, ptr %110, align 8
  %112 = xor i64 %111, -1
  %113 = add nuw i64 %102, 1
  %114 = mul i64 %113, %2
  %115 = add i64 %114, %112
  %116 = getelementptr i8, ptr %20, i64 %115
  store i8 79, ptr %116, align 1
  %117 = getelementptr i64, ptr %21, i64 %102
  %118 = load i64, ptr %117, align 8
  %119 = add i64 %118, 1
  store i64 %119, ptr %117, align 8
  %120 = add i64 %101, %result.1.1
  br label %switch.done.2

switch.done.2:                                    ; preds = %switch.case.body.2, %switch.case.body1.2, %switch.done.1
  %result.1.2 = phi i64 [ %result.1.1, %switch.done.1 ], [ %result.1.1, %switch.case.body1.2 ], [ %120, %switch.case.body.2 ]
  %121 = or i64 %52, 3
  %122 = getelementptr i8, ptr %22, i64 %121
  %123 = load i8, ptr %122, align 1
  %124 = sdiv i64 %121, %2
  %125 = srem i64 %121, %2
  switch i8 %123, label %switch.done.3 [
    i8 79, label %switch.case.body.3
    i8 35, label %switch.case.body1.3
  ]

switch.case.body1.3:                              ; preds = %switch.done.2
  %126 = mul i64 %125, %2
  %127 = xor i64 %124, -1
  %128 = add i64 %2, %127
  %129 = add i64 %128, %126
  %130 = getelementptr i8, ptr %23, i64 %129
  store i8 35, ptr %130, align 1
  %131 = getelementptr i64, ptr %24, i64 %125
  %132 = add i64 %124, 1
  store i64 %132, ptr %131, align 8
  br label %switch.done.3

switch.case.body.3:                               ; preds = %switch.done.2
  %133 = getelementptr i64, ptr %25, i64 %125
  %134 = load i64, ptr %133, align 8
  %135 = xor i64 %134, -1
  %136 = add nuw i64 %125, 1
  %137 = mul i64 %136, %2
  %138 = add i64 %137, %135
  %139 = getelementptr i8, ptr %26, i64 %138
  store i8 79, ptr %139, align 1
  %140 = getelementptr i64, ptr %27, i64 %125
  %141 = load i64, ptr %140, align 8
  %142 = add i64 %141, 1
  store i64 %142, ptr %140, align 8
  %143 = add i64 %124, %result.1.2
  br label %switch.done.3

switch.done.3:                                    ; preds = %switch.case.body.3, %switch.case.body1.3, %switch.done.2
  %result.1.3 = phi i64 [ %result.1.2, %switch.done.2 ], [ %result.1.2, %switch.case.body1.3 ], [ %143, %switch.case.body.3 ]
  %144 = or i64 %52, 4
  %145 = getelementptr i8, ptr %28, i64 %144
  %146 = load i8, ptr %145, align 1
  %147 = sdiv i64 %144, %2
  %148 = srem i64 %144, %2
  switch i8 %146, label %switch.done.4 [
    i8 79, label %switch.case.body.4
    i8 35, label %switch.case.body1.4
  ]

switch.case.body1.4:                              ; preds = %switch.done.3
  %149 = mul i64 %148, %2
  %150 = xor i64 %147, -1
  %151 = add i64 %2, %150
  %152 = add i64 %151, %149
  %153 = getelementptr i8, ptr %29, i64 %152
  store i8 35, ptr %153, align 1
  %154 = getelementptr i64, ptr %30, i64 %148
  %155 = add i64 %147, 1
  store i64 %155, ptr %154, align 8
  br label %switch.done.4

switch.case.body.4:                               ; preds = %switch.done.3
  %156 = getelementptr i64, ptr %31, i64 %148
  %157 = load i64, ptr %156, align 8
  %158 = xor i64 %157, -1
  %159 = add nuw i64 %148, 1
  %160 = mul i64 %159, %2
  %161 = add i64 %160, %158
  %162 = getelementptr i8, ptr %32, i64 %161
  store i8 79, ptr %162, align 1
  %163 = getelementptr i64, ptr %33, i64 %148
  %164 = load i64, ptr %163, align 8
  %165 = add i64 %164, 1
  store i64 %165, ptr %163, align 8
  %166 = add i64 %147, %result.1.3
  br label %switch.done.4

switch.done.4:                                    ; preds = %switch.case.body.4, %switch.case.body1.4, %switch.done.3
  %result.1.4 = phi i64 [ %result.1.3, %switch.done.3 ], [ %result.1.3, %switch.case.body1.4 ], [ %166, %switch.case.body.4 ]
  %167 = or i64 %52, 5
  %168 = getelementptr i8, ptr %34, i64 %167
  %169 = load i8, ptr %168, align 1
  %170 = sdiv i64 %167, %2
  %171 = srem i64 %167, %2
  switch i8 %169, label %switch.done.5 [
    i8 79, label %switch.case.body.5
    i8 35, label %switch.case.body1.5
  ]

switch.case.body1.5:                              ; preds = %switch.done.4
  %172 = mul i64 %171, %2
  %173 = xor i64 %170, -1
  %174 = add i64 %2, %173
  %175 = add i64 %174, %172
  %176 = getelementptr i8, ptr %35, i64 %175
  store i8 35, ptr %176, align 1
  %177 = getelementptr i64, ptr %36, i64 %171
  %178 = add i64 %170, 1
  store i64 %178, ptr %177, align 8
  br label %switch.done.5

switch.case.body.5:                               ; preds = %switch.done.4
  %179 = getelementptr i64, ptr %37, i64 %171
  %180 = load i64, ptr %179, align 8
  %181 = xor i64 %180, -1
  %182 = add nuw i64 %171, 1
  %183 = mul i64 %182, %2
  %184 = add i64 %183, %181
  %185 = getelementptr i8, ptr %38, i64 %184
  store i8 79, ptr %185, align 1
  %186 = getelementptr i64, ptr %39, i64 %171
  %187 = load i64, ptr %186, align 8
  %188 = add i64 %187, 1
  store i64 %188, ptr %186, align 8
  %189 = add i64 %170, %result.1.4
  br label %switch.done.5

switch.done.5:                                    ; preds = %switch.case.body.5, %switch.case.body1.5, %switch.done.4
  %result.1.5 = phi i64 [ %result.1.4, %switch.done.4 ], [ %result.1.4, %switch.case.body1.5 ], [ %189, %switch.case.body.5 ]
  %190 = or i64 %52, 6
  %191 = getelementptr i8, ptr %40, i64 %190
  %192 = load i8, ptr %191, align 1
  %193 = sdiv i64 %190, %2
  %194 = srem i64 %190, %2
  switch i8 %192, label %switch.done.6 [
    i8 79, label %switch.case.body.6
    i8 35, label %switch.case.body1.6
  ]

switch.case.body1.6:                              ; preds = %switch.done.5
  %195 = mul i64 %194, %2
  %196 = xor i64 %193, -1
  %197 = add i64 %2, %196
  %198 = add i64 %197, %195
  %199 = getelementptr i8, ptr %41, i64 %198
  store i8 35, ptr %199, align 1
  %200 = getelementptr i64, ptr %42, i64 %194
  %201 = add i64 %193, 1
  store i64 %201, ptr %200, align 8
  br label %switch.done.6

switch.case.body.6:                               ; preds = %switch.done.5
  %202 = getelementptr i64, ptr %43, i64 %194
  %203 = load i64, ptr %202, align 8
  %204 = xor i64 %203, -1
  %205 = add nuw i64 %194, 1
  %206 = mul i64 %205, %2
  %207 = add i64 %206, %204
  %208 = getelementptr i8, ptr %44, i64 %207
  store i8 79, ptr %208, align 1
  %209 = getelementptr i64, ptr %45, i64 %194
  %210 = load i64, ptr %209, align 8
  %211 = add i64 %210, 1
  store i64 %211, ptr %209, align 8
  %212 = add i64 %193, %result.1.5
  br label %switch.done.6

switch.done.6:                                    ; preds = %switch.case.body.6, %switch.case.body1.6, %switch.done.5
  %result.1.6 = phi i64 [ %result.1.5, %switch.done.5 ], [ %result.1.5, %switch.case.body1.6 ], [ %212, %switch.case.body.6 ]
  %213 = or i64 %52, 7
  %214 = getelementptr i8, ptr %46, i64 %213
  %215 = load i8, ptr %214, align 1
  %216 = sdiv i64 %213, %2
  %217 = srem i64 %213, %2
  switch i8 %215, label %switch.done.7 [
    i8 79, label %switch.case.body.7
    i8 35, label %switch.case.body1.7
  ]

switch.case.body1.7:                              ; preds = %switch.done.6
  %218 = mul i64 %217, %2
  %219 = xor i64 %216, -1
  %220 = add i64 %2, %219
  %221 = add i64 %220, %218
  %222 = getelementptr i8, ptr %47, i64 %221
  store i8 35, ptr %222, align 1
  %223 = getelementptr i64, ptr %48, i64 %217
  %224 = add i64 %216, 1
  store i64 %224, ptr %223, align 8
  br label %switch.done.7

switch.case.body.7:                               ; preds = %switch.done.6
  %225 = getelementptr i64, ptr %49, i64 %217
  %226 = load i64, ptr %225, align 8
  %227 = xor i64 %226, -1
  %228 = add nuw i64 %217, 1
  %229 = mul i64 %228, %2
  %230 = add i64 %229, %227
  %231 = getelementptr i8, ptr %50, i64 %230
  store i8 79, ptr %231, align 1
  %232 = getelementptr i64, ptr %51, i64 %217
  %233 = load i64, ptr %232, align 8
  %234 = add i64 %233, 1
  store i64 %234, ptr %232, align 8
  %235 = add i64 %216, %result.1.6
  br label %switch.done.7

switch.done.7:                                    ; preds = %switch.case.body.7, %switch.case.body1.7, %switch.done.6
  %result.1.7 = phi i64 [ %result.1.6, %switch.done.6 ], [ %result.1.6, %switch.case.body1.7 ], [ %235, %switch.case.body.7 ]
  %236 = add nuw nsw i64 %52, 8
  %niter.next.7 = add i64 %niter, 8
  %niter.ncmp.7 = icmp eq i64 %niter.next.7, %unroll_iter
  br i1 %niter.ncmp.7, label %for.index.done.loopexit.unr-lcssa, label %for.index.body

for.index.done.loopexit.unr-lcssa:                ; preds = %switch.done.7, %for.index.body.lr.ph
  %result.1.lcssa.ph = phi i64 [ undef, %for.index.body.lr.ph ], [ %result.1.7, %switch.done.7 ]
  %.unr = phi i64 [ 0, %for.index.body.lr.ph ], [ %236, %switch.done.7 ]
  %result.03.unr = phi i64 [ 0, %for.index.body.lr.ph ], [ %result.1.7, %switch.done.7 ]
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %for.index.done, label %for.index.body.epil.preheader

for.index.body.epil.preheader:                    ; preds = %for.index.done.loopexit.unr-lcssa
  %237 = load ptr, ptr @opt_ex.big_grid_1.0, align 8
  %238 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %239 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %240 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %241 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %242 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  br label %for.index.body.epil

for.index.body.epil:                              ; preds = %switch.done.epil, %for.index.body.epil.preheader
  %243 = phi i64 [ %.unr, %for.index.body.epil.preheader ], [ %266, %switch.done.epil ]
  %result.03.epil = phi i64 [ %result.03.unr, %for.index.body.epil.preheader ], [ %result.1.epil, %switch.done.epil ]
  %epil.iter = phi i64 [ 0, %for.index.body.epil.preheader ], [ %epil.iter.next, %switch.done.epil ]
  %244 = getelementptr i8, ptr %237, i64 %243
  %245 = load i8, ptr %244, align 1
  %246 = sdiv i64 %243, %2
  %247 = srem i64 %243, %2
  switch i8 %245, label %switch.done.epil [
    i8 79, label %switch.case.body.epil
    i8 35, label %switch.case.body1.epil
  ]

switch.case.body1.epil:                           ; preds = %for.index.body.epil
  %248 = mul i64 %247, %2
  %249 = xor i64 %246, -1
  %250 = add i64 %2, %249
  %251 = add i64 %250, %248
  %252 = getelementptr i8, ptr %238, i64 %251
  store i8 35, ptr %252, align 1
  %253 = getelementptr i64, ptr %239, i64 %247
  %254 = add i64 %246, 1
  store i64 %254, ptr %253, align 8
  br label %switch.done.epil

switch.case.body.epil:                            ; preds = %for.index.body.epil
  %255 = getelementptr i64, ptr %240, i64 %247
  %256 = load i64, ptr %255, align 8
  %257 = xor i64 %256, -1
  %258 = add nuw i64 %247, 1
  %259 = mul i64 %258, %2
  %260 = add i64 %259, %257
  %261 = getelementptr i8, ptr %241, i64 %260
  store i8 79, ptr %261, align 1
  %262 = getelementptr i64, ptr %242, i64 %247
  %263 = load i64, ptr %262, align 8
  %264 = add i64 %263, 1
  store i64 %264, ptr %262, align 8
  %265 = add i64 %246, %result.03.epil
  br label %switch.done.epil

switch.done.epil:                                 ; preds = %switch.case.body.epil, %switch.case.body1.epil, %for.index.body.epil
  %result.1.epil = phi i64 [ %result.03.epil, %for.index.body.epil ], [ %result.03.epil, %switch.case.body1.epil ], [ %265, %switch.case.body.epil ]
  %266 = add nuw nsw i64 %243, 1
  %epil.iter.next = add i64 %epil.iter, 1
  %epil.iter.cmp.not = icmp eq i64 %epil.iter.next, %xtraiter
  br i1 %epil.iter.cmp.not, label %for.index.done, label %for.index.body.epil, !llvm.loop !300

for.index.done:                                   ; preds = %for.index.done.loopexit.unr-lcssa, %switch.done.epil, %decls
  %result.0.lcssa = phi i64 [ 0, %decls ], [ %result.1.lcssa.ph, %for.index.done.loopexit.unr-lcssa ], [ %result.1.epil, %switch.done.epil ]
  ret i64 %result.0.lcssa
}