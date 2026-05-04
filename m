Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7E34753B;
	Mon,  4 May 2026 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929653; cv=none; b=NzrI3y09gzSfLSdzdiLhxXp08qrvkYxJrvSpLvt6nzpgJeAAjJSOSLA9Hh/GBKDhknuuQwGW7sVLgUdR++4mKKFJgCjdmeD+R3xaygQWHieEXj727lO1pu/u7xX2wCZSXAiJrzuv2EdG9O3euhrd2679zP2cH7YPCzGptL+YRSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929653; c=relaxed/simple;
	bh=Xb7kBjBbjGlJMAF9AoTR4uxn6kGkjn8XMrWWPdjs5rc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ukstiYnRgu6+GV7gAgqMAJT414Mqi8zPjgzlFDWBcN4WK3tXfu7GaziojwDFBS+8yl1k95j2d4ziy0H5ZPkNCvEfin58ErtcD2WkLNDu8bDGpVu2C9N1YE2XnwDAvMedUqrvBgjX8cATzkTHKBFMfz95ppXYOuY8nL7b1grskZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYQffGTm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYQffGTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31305C2BCB8;
	Mon,  4 May 2026 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777929653;
	bh=Xb7kBjBbjGlJMAF9AoTR4uxn6kGkjn8XMrWWPdjs5rc=;
	h=Date:From:To:Cc:Subject:From;
	b=cYQffGTmfWkPwz6pVp0Hx4nOmWzY7t6HKqc+wVzV76eiTCYpGZm8mvU2AKutRqGbh
	 FeA16wa4hENL1W6z3UdEIHUBeUG7CpeME7qX/EBU+ud090w/EPQAZFAz5mnBHBcb36
	 Piy9BEYRMZWSKSZgOv6bHFiJJWlXmusyX2vg3c1eMT9O8ZzfWcbBdPO7D2Jlvidi/z
	 0O9wBuTFgEuS65rZsN1+eawvsJLoxxytnsPLH3KeuoQwUHE6UX3Nl+P66xPnC+bYHg
	 sl3nlhUjYTbIYiHp6jzXlRo7eAoPv8jgi6TySTsj1SyW9YI03HxSaYm/GugxvooxW6
	 5LPPQoD0kAQUQ==
Date: Mon, 04 May 2026 11:20:52 -1000
Message-ID: <d49b20910d6d09389af138f45acbfaf0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 kernel test robot <lkp@intel.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2] sched_ext: Add __printf format attributes to scx_vexit() and bstr formatters
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_vexit() forwards (fmt, args) to vscnprintf(); bstr_format() and
__bstr_format() forward fmt to bstr_printf(); the BPF kfunc wrappers
scx_bpf_exit_bstr(), scx_bpf_error_bstr() and scx_bpf_dump_bstr() in
turn forward fmt to those formatters. None of them have __printf(),
so clang -Wmissing-format-attribute fires on the forwarded calls and
C-side callers don't get format-string checking.

Annotate the six functions with __printf(N, 0) matching the fmt
parameter position in each.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202605041112.Y6OG7v9r-lkp@intel.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 5 +++++
 kernel/sched/ext_internal.h | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 966a846c213c..7ac7d10a41be 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9338,6 +9338,7 @@ __bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux *aux)

 __bpf_kfunc_end_defs();

+__printf(5, 0)
 static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
 			 size_t line_size, char *fmt, unsigned long long *data,
 			 u32 data__sz)
@@ -9375,6 +9376,7 @@ static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
 	return ret;
 }

+__printf(3, 0)
 static s32 bstr_format(struct scx_sched *sch, struct scx_bstr_buf *buf,
 		       char *fmt, unsigned long long *data, u32 data__sz)
 {
@@ -9395,6 +9397,7 @@ __bpf_kfunc_start_defs();
  * Indicate that the BPF scheduler wants to exit gracefully, and initiate ops
  * disabling.
  */
+__printf(2, 0)
 __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
 				   unsigned long long *data, u32 data__sz,
 				   const struct bpf_prog_aux *aux)
@@ -9420,6 +9423,7 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
  * Indicate that the BPF scheduler encountered a fatal error and initiate ops
  * disabling.
  */
+__printf(1, 0)
 __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
 				    u32 data__sz, const struct bpf_prog_aux *aux)
 {
@@ -9447,6 +9451,7 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
  * The extra dump may be multiple lines. A single line may be split over
  * multiple calls. The last line is automatically terminated.
  */
+__printf(1, 0)
 __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 				   u32 data__sz, const struct bpf_prog_aux *aux)
 {
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b4f5dd28855e..0ed79bd891c7 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1477,8 +1477,9 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);

 bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where);

-bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind, s64 exit_code,
-	       s32 exit_cpu, const char *fmt, va_list args);
+__printf(5, 0) bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
+			      s64 exit_code, s32 exit_cpu, const char *fmt,
+			      va_list args);
 __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
 			       s64 exit_code, s32 exit_cpu, const char *fmt, ...);

--
2.47.0
