; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none)
define internal i64 @opt_ex.aocloop_do_work_2(ptr noalias nocapture nonnull readnone %__.context_ptr) #7 {
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
  %52 = phi i64 [ 0, %for.index.body.lr.ph.new ], [ %252, %switch.done.7 ]
  %result.03 = phi i64 [ 0, %for.index.body.lr.ph.new ], [ %result.1.7, %switch.done.7 ]
  %niter = phi i64 [ 0, %for.index.body.lr.ph.new ], [ %niter.next.7, %switch.done.7 ]
  %53 = getelementptr i8, ptr %4, i64 %52
  %54 = load i8, ptr %53, align 1
  switch i8 %54, label %switch.done [
    i8 79, label %switch.case.body
    i8 35, label %switch.case.body1
  ]

switch.case.body:                                 ; preds = %for.index.body
  %55 = srem i64 %52, %2
  %56 = getelementptr i64, ptr %7, i64 %55
  %57 = load i64, ptr %56, align 8
  %58 = mul i64 %55, %2
  %59 = xor i64 %57, -1
  %60 = add i64 %2, %59
  %61 = add i64 %60, %58
  %62 = getelementptr i8, ptr %8, i64 %61
  store i8 79, ptr %62, align 1
  %63 = getelementptr i64, ptr %9, i64 %55
  %64 = load i64, ptr %63, align 8
  %65 = add i64 %64, 1
  store i64 %65, ptr %63, align 8
  %66 = sdiv i64 %52, %2
  %67 = add i64 %66, %result.03
  br label %switch.done

switch.case.body1:                                ; preds = %for.index.body
  %68 = srem i64 %52, %2
  %69 = mul i64 %68, %2
  %70 = sdiv i64 %52, %2
  %71 = xor i64 %70, -1
  %72 = add i64 %2, %71
  %73 = add i64 %72, %69
  %74 = getelementptr i8, ptr %5, i64 %73
  store i8 35, ptr %74, align 1
  %75 = getelementptr i64, ptr %6, i64 %68
  %76 = add i64 %70, 1
  store i64 %76, ptr %75, align 8
  br label %switch.done

switch.done:                                      ; preds = %switch.case.body1, %switch.case.body, %for.index.body
  %result.1 = phi i64 [ %result.03, %for.index.body ], [ %result.03, %switch.case.body1 ], [ %67, %switch.case.body ]
  %77 = or i64 %52, 1
  %78 = getelementptr i8, ptr %10, i64 %77
  %79 = load i8, ptr %78, align 1
  switch i8 %79, label %switch.done.1 [
    i8 79, label %switch.case.body.1
    i8 35, label %switch.case.body1.1
  ]

switch.case.body1.1:                              ; preds = %switch.done
  %80 = srem i64 %77, %2
  %81 = mul i64 %80, %2
  %82 = sdiv i64 %77, %2
  %83 = xor i64 %82, -1
  %84 = add i64 %2, %83
  %85 = add i64 %84, %81
  %86 = getelementptr i8, ptr %11, i64 %85
  store i8 35, ptr %86, align 1
  %87 = getelementptr i64, ptr %12, i64 %80
  %88 = add i64 %82, 1
  store i64 %88, ptr %87, align 8
  br label %switch.done.1

switch.case.body.1:                               ; preds = %switch.done
  %89 = srem i64 %77, %2
  %90 = getelementptr i64, ptr %13, i64 %89
  %91 = load i64, ptr %90, align 8
  %92 = mul i64 %89, %2
  %93 = xor i64 %91, -1
  %94 = add i64 %2, %93
  %95 = add i64 %94, %92
  %96 = getelementptr i8, ptr %14, i64 %95
  store i8 79, ptr %96, align 1
  %97 = getelementptr i64, ptr %15, i64 %89
  %98 = load i64, ptr %97, align 8
  %99 = add i64 %98, 1
  store i64 %99, ptr %97, align 8
  %100 = sdiv i64 %77, %2
  %101 = add i64 %100, %result.1
  br label %switch.done.1

switch.done.1:                                    ; preds = %switch.case.body.1, %switch.case.body1.1, %switch.done
  %result.1.1 = phi i64 [ %result.1, %switch.done ], [ %result.1, %switch.case.body1.1 ], [ %101, %switch.case.body.1 ]
  %102 = or i64 %52, 2
  %103 = getelementptr i8, ptr %16, i64 %102
  %104 = load i8, ptr %103, align 1
  switch i8 %104, label %switch.done.2 [
    i8 79, label %switch.case.body.2
    i8 35, label %switch.case.body1.2
  ]

switch.case.body1.2:                              ; preds = %switch.done.1
  %105 = srem i64 %102, %2
  %106 = mul i64 %105, %2
  %107 = sdiv i64 %102, %2
  %108 = xor i64 %107, -1
  %109 = add i64 %2, %108
  %110 = add i64 %109, %106
  %111 = getelementptr i8, ptr %17, i64 %110
  store i8 35, ptr %111, align 1
  %112 = getelementptr i64, ptr %18, i64 %105
  %113 = add i64 %107, 1
  store i64 %113, ptr %112, align 8
  br label %switch.done.2

switch.case.body.2:                               ; preds = %switch.done.1
  %114 = srem i64 %102, %2
  %115 = getelementptr i64, ptr %19, i64 %114
  %116 = load i64, ptr %115, align 8
  %117 = mul i64 %114, %2
  %118 = xor i64 %116, -1
  %119 = add i64 %2, %118
  %120 = add i64 %119, %117
  %121 = getelementptr i8, ptr %20, i64 %120
  store i8 79, ptr %121, align 1
  %122 = getelementptr i64, ptr %21, i64 %114
  %123 = load i64, ptr %122, align 8
  %124 = add i64 %123, 1
  store i64 %124, ptr %122, align 8
  %125 = sdiv i64 %102, %2
  %126 = add i64 %125, %result.1.1
  br label %switch.done.2

switch.done.2:                                    ; preds = %switch.case.body.2, %switch.case.body1.2, %switch.done.1
  %result.1.2 = phi i64 [ %result.1.1, %switch.done.1 ], [ %result.1.1, %switch.case.body1.2 ], [ %126, %switch.case.body.2 ]
  %127 = or i64 %52, 3
  %128 = getelementptr i8, ptr %22, i64 %127
  %129 = load i8, ptr %128, align 1
  switch i8 %129, label %switch.done.3 [
    i8 79, label %switch.case.body.3
    i8 35, label %switch.case.body1.3
  ]

switch.case.body1.3:                              ; preds = %switch.done.2
  %130 = srem i64 %127, %2
  %131 = mul i64 %130, %2
  %132 = sdiv i64 %127, %2
  %133 = xor i64 %132, -1
  %134 = add i64 %2, %133
  %135 = add i64 %134, %131
  %136 = getelementptr i8, ptr %23, i64 %135
  store i8 35, ptr %136, align 1
  %137 = getelementptr i64, ptr %24, i64 %130
  %138 = add i64 %132, 1
  store i64 %138, ptr %137, align 8
  br label %switch.done.3

switch.case.body.3:                               ; preds = %switch.done.2
  %139 = srem i64 %127, %2
  %140 = getelementptr i64, ptr %25, i64 %139
  %141 = load i64, ptr %140, align 8
  %142 = mul i64 %139, %2
  %143 = xor i64 %141, -1
  %144 = add i64 %2, %143
  %145 = add i64 %144, %142
  %146 = getelementptr i8, ptr %26, i64 %145
  store i8 79, ptr %146, align 1
  %147 = getelementptr i64, ptr %27, i64 %139
  %148 = load i64, ptr %147, align 8
  %149 = add i64 %148, 1
  store i64 %149, ptr %147, align 8
  %150 = sdiv i64 %127, %2
  %151 = add i64 %150, %result.1.2
  br label %switch.done.3

switch.done.3:                                    ; preds = %switch.case.body.3, %switch.case.body1.3, %switch.done.2
  %result.1.3 = phi i64 [ %result.1.2, %switch.done.2 ], [ %result.1.2, %switch.case.body1.3 ], [ %151, %switch.case.body.3 ]
  %152 = or i64 %52, 4
  %153 = getelementptr i8, ptr %28, i64 %152
  %154 = load i8, ptr %153, align 1
  switch i8 %154, label %switch.done.4 [
    i8 79, label %switch.case.body.4
    i8 35, label %switch.case.body1.4
  ]

switch.case.body1.4:                              ; preds = %switch.done.3
  %155 = srem i64 %152, %2
  %156 = mul i64 %155, %2
  %157 = sdiv i64 %152, %2
  %158 = xor i64 %157, -1
  %159 = add i64 %2, %158
  %160 = add i64 %159, %156
  %161 = getelementptr i8, ptr %29, i64 %160
  store i8 35, ptr %161, align 1
  %162 = getelementptr i64, ptr %30, i64 %155
  %163 = add i64 %157, 1
  store i64 %163, ptr %162, align 8
  br label %switch.done.4

switch.case.body.4:                               ; preds = %switch.done.3
  %164 = srem i64 %152, %2
  %165 = getelementptr i64, ptr %31, i64 %164
  %166 = load i64, ptr %165, align 8
  %167 = mul i64 %164, %2
  %168 = xor i64 %166, -1
  %169 = add i64 %2, %168
  %170 = add i64 %169, %167
  %171 = getelementptr i8, ptr %32, i64 %170
  store i8 79, ptr %171, align 1
  %172 = getelementptr i64, ptr %33, i64 %164
  %173 = load i64, ptr %172, align 8
  %174 = add i64 %173, 1
  store i64 %174, ptr %172, align 8
  %175 = sdiv i64 %152, %2
  %176 = add i64 %175, %result.1.3
  br label %switch.done.4

switch.done.4:                                    ; preds = %switch.case.body.4, %switch.case.body1.4, %switch.done.3
  %result.1.4 = phi i64 [ %result.1.3, %switch.done.3 ], [ %result.1.3, %switch.case.body1.4 ], [ %176, %switch.case.body.4 ]
  %177 = or i64 %52, 5
  %178 = getelementptr i8, ptr %34, i64 %177
  %179 = load i8, ptr %178, align 1
  switch i8 %179, label %switch.done.5 [
    i8 79, label %switch.case.body.5
    i8 35, label %switch.case.body1.5
  ]

switch.case.body1.5:                              ; preds = %switch.done.4
  %180 = srem i64 %177, %2
  %181 = mul i64 %180, %2
  %182 = sdiv i64 %177, %2
  %183 = xor i64 %182, -1
  %184 = add i64 %2, %183
  %185 = add i64 %184, %181
  %186 = getelementptr i8, ptr %35, i64 %185
  store i8 35, ptr %186, align 1
  %187 = getelementptr i64, ptr %36, i64 %180
  %188 = add i64 %182, 1
  store i64 %188, ptr %187, align 8
  br label %switch.done.5

switch.case.body.5:                               ; preds = %switch.done.4
  %189 = srem i64 %177, %2
  %190 = getelementptr i64, ptr %37, i64 %189
  %191 = load i64, ptr %190, align 8
  %192 = mul i64 %189, %2
  %193 = xor i64 %191, -1
  %194 = add i64 %2, %193
  %195 = add i64 %194, %192
  %196 = getelementptr i8, ptr %38, i64 %195
  store i8 79, ptr %196, align 1
  %197 = getelementptr i64, ptr %39, i64 %189
  %198 = load i64, ptr %197, align 8
  %199 = add i64 %198, 1
  store i64 %199, ptr %197, align 8
  %200 = sdiv i64 %177, %2
  %201 = add i64 %200, %result.1.4
  br label %switch.done.5

switch.done.5:                                    ; preds = %switch.case.body.5, %switch.case.body1.5, %switch.done.4
  %result.1.5 = phi i64 [ %result.1.4, %switch.done.4 ], [ %result.1.4, %switch.case.body1.5 ], [ %201, %switch.case.body.5 ]
  %202 = or i64 %52, 6
  %203 = getelementptr i8, ptr %40, i64 %202
  %204 = load i8, ptr %203, align 1
  switch i8 %204, label %switch.done.6 [
    i8 79, label %switch.case.body.6
    i8 35, label %switch.case.body1.6
  ]

switch.case.body1.6:                              ; preds = %switch.done.5
  %205 = srem i64 %202, %2
  %206 = mul i64 %205, %2
  %207 = sdiv i64 %202, %2
  %208 = xor i64 %207, -1
  %209 = add i64 %2, %208
  %210 = add i64 %209, %206
  %211 = getelementptr i8, ptr %41, i64 %210
  store i8 35, ptr %211, align 1
  %212 = getelementptr i64, ptr %42, i64 %205
  %213 = add i64 %207, 1
  store i64 %213, ptr %212, align 8
  br label %switch.done.6

switch.case.body.6:                               ; preds = %switch.done.5
  %214 = srem i64 %202, %2
  %215 = getelementptr i64, ptr %43, i64 %214
  %216 = load i64, ptr %215, align 8
  %217 = mul i64 %214, %2
  %218 = xor i64 %216, -1
  %219 = add i64 %2, %218
  %220 = add i64 %219, %217
  %221 = getelementptr i8, ptr %44, i64 %220
  store i8 79, ptr %221, align 1
  %222 = getelementptr i64, ptr %45, i64 %214
  %223 = load i64, ptr %222, align 8
  %224 = add i64 %223, 1
  store i64 %224, ptr %222, align 8
  %225 = sdiv i64 %202, %2
  %226 = add i64 %225, %result.1.5
  br label %switch.done.6

switch.done.6:                                    ; preds = %switch.case.body.6, %switch.case.body1.6, %switch.done.5
  %result.1.6 = phi i64 [ %result.1.5, %switch.done.5 ], [ %result.1.5, %switch.case.body1.6 ], [ %226, %switch.case.body.6 ]
  %227 = or i64 %52, 7
  %228 = getelementptr i8, ptr %46, i64 %227
  %229 = load i8, ptr %228, align 1
  switch i8 %229, label %switch.done.7 [
    i8 79, label %switch.case.body.7
    i8 35, label %switch.case.body1.7
  ]

switch.case.body1.7:                              ; preds = %switch.done.6
  %230 = srem i64 %227, %2
  %231 = mul i64 %230, %2
  %232 = sdiv i64 %227, %2
  %233 = xor i64 %232, -1
  %234 = add i64 %2, %233
  %235 = add i64 %234, %231
  %236 = getelementptr i8, ptr %47, i64 %235
  store i8 35, ptr %236, align 1
  %237 = getelementptr i64, ptr %48, i64 %230
  %238 = add i64 %232, 1
  store i64 %238, ptr %237, align 8
  br label %switch.done.7

switch.case.body.7:                               ; preds = %switch.done.6
  %239 = srem i64 %227, %2
  %240 = getelementptr i64, ptr %49, i64 %239
  %241 = load i64, ptr %240, align 8
  %242 = mul i64 %239, %2
  %243 = xor i64 %241, -1
  %244 = add i64 %2, %243
  %245 = add i64 %244, %242
  %246 = getelementptr i8, ptr %50, i64 %245
  store i8 79, ptr %246, align 1
  %247 = getelementptr i64, ptr %51, i64 %239
  %248 = load i64, ptr %247, align 8
  %249 = add i64 %248, 1
  store i64 %249, ptr %247, align 8
  %250 = sdiv i64 %227, %2
  %251 = add i64 %250, %result.1.6
  br label %switch.done.7

switch.done.7:                                    ; preds = %switch.case.body.7, %switch.case.body1.7, %switch.done.6
  %result.1.7 = phi i64 [ %result.1.6, %switch.done.6 ], [ %result.1.6, %switch.case.body1.7 ], [ %251, %switch.case.body.7 ]
  %252 = add nuw nsw i64 %52, 8
  %niter.next.7 = add i64 %niter, 8
  %niter.ncmp.7 = icmp eq i64 %niter.next.7, %unroll_iter
  br i1 %niter.ncmp.7, label %for.index.done.loopexit.unr-lcssa, label %for.index.body

for.index.done.loopexit.unr-lcssa:                ; preds = %switch.done.7, %for.index.body.lr.ph
  %result.1.lcssa.ph = phi i64 [ undef, %for.index.body.lr.ph ], [ %result.1.7, %switch.done.7 ]
  %.unr = phi i64 [ 0, %for.index.body.lr.ph ], [ %252, %switch.done.7 ]
  %result.03.unr = phi i64 [ 0, %for.index.body.lr.ph ], [ %result.1.7, %switch.done.7 ]
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %for.index.done, label %for.index.body.epil.preheader

for.index.body.epil.preheader:                    ; preds = %for.index.done.loopexit.unr-lcssa
  %253 = load ptr, ptr @opt_ex.big_grid_1.0, align 8
  %254 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %255 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %256 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  %257 = load ptr, ptr @opt_ex.big_grid_2.0, align 8
  %258 = load ptr, ptr @opt_ex.row_col_data.0, align 8
  br label %for.index.body.epil

for.index.body.epil:                              ; preds = %switch.done.epil, %for.index.body.epil.preheader
  %259 = phi i64 [ %.unr, %for.index.body.epil.preheader ], [ %284, %switch.done.epil ]
  %result.03.epil = phi i64 [ %result.03.unr, %for.index.body.epil.preheader ], [ %result.1.epil, %switch.done.epil ]
  %epil.iter = phi i64 [ 0, %for.index.body.epil.preheader ], [ %epil.iter.next, %switch.done.epil ]
  %260 = getelementptr i8, ptr %253, i64 %259
  %261 = load i8, ptr %260, align 1
  switch i8 %261, label %switch.done.epil [
    i8 79, label %switch.case.body.epil
    i8 35, label %switch.case.body1.epil
  ]

switch.case.body1.epil:                           ; preds = %for.index.body.epil
  %262 = srem i64 %259, %2
  %263 = mul i64 %262, %2
  %264 = sdiv i64 %259, %2
  %265 = xor i64 %264, -1
  %266 = add i64 %2, %265
  %267 = add i64 %266, %263
  %268 = getelementptr i8, ptr %254, i64 %267
  store i8 35, ptr %268, align 1
  %269 = getelementptr i64, ptr %255, i64 %262
  %270 = add i64 %264, 1
  store i64 %270, ptr %269, align 8
  br label %switch.done.epil

switch.case.body.epil:                            ; preds = %for.index.body.epil
  %271 = srem i64 %259, %2
  %272 = getelementptr i64, ptr %256, i64 %271
  %273 = load i64, ptr %272, align 8
  %274 = mul i64 %271, %2
  %275 = xor i64 %273, -1
  %276 = add i64 %2, %275
  %277 = add i64 %276, %274
  %278 = getelementptr i8, ptr %257, i64 %277
  store i8 79, ptr %278, align 1
  %279 = getelementptr i64, ptr %258, i64 %271
  %280 = load i64, ptr %279, align 8
  %281 = add i64 %280, 1
  store i64 %281, ptr %279, align 8
  %282 = sdiv i64 %259, %2
  %283 = add i64 %282, %result.03.epil
  br label %switch.done.epil

switch.done.epil:                                 ; preds = %switch.case.body.epil, %switch.case.body1.epil, %for.index.body.epil
  %result.1.epil = phi i64 [ %result.03.epil, %for.index.body.epil ], [ %result.03.epil, %switch.case.body1.epil ], [ %283, %switch.case.body.epil ]
  %284 = add nuw nsw i64 %259, 1
  %epil.iter.next = add i64 %epil.iter, 1
  %epil.iter.cmp.not = icmp eq i64 %epil.iter.next, %xtraiter
  br i1 %epil.iter.cmp.not, label %for.index.done, label %for.index.body.epil, !llvm.loop !301

for.index.done:                                   ; preds = %for.index.done.loopexit.unr-lcssa, %switch.done.epil, %decls
  %result.0.lcssa = phi i64 [ 0, %decls ], [ %result.1.lcssa.ph, %for.index.done.loopexit.unr-lcssa ], [ %result.1.epil, %switch.done.epil ]
  ret i64 %result.0.lcssa
}