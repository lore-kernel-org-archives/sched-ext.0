Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE33112C0;
	Mon, 22 Sep 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557680; cv=none; b=RrUXYoFZ3jMQUKB/XgrlntsUd+fn8DfLT48W6BTOIYnK+Gj2nSDbNixjYXBylmRLk4pZe2Q6KKndIUbvJ2QogJ3ClOFqxf/jzQCTEMXjLdteWMGUtJjAp5by1JHDdrfwft4dR0UmB495gnpW+z/HRIQadjuZGdmcF3atvEGoRa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557680; c=relaxed/simple;
	bh=sKB4bCRqrQ6QNUoiR1E0P3ED5YCM9T/aWEA+L5rnn/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvzJH0B4PPMYLb4ux5HM7IV/E45RNb/s42xAgzzeoAoqQD3aXlkR+ts22LqgTNCvwEoRMMwfez1aVQdH6gXsr21tgIGmoBMPcCwljZhLTFKF5Bp1kgdOyGGT/VeF69JC8eY51HuKNBRJdV4A3uQ/iQQFANo2m1TP0bSPUifIp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK1d6C0j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK1d6C0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66114C4CEF0;
	Mon, 22 Sep 2025 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557679;
	bh=sKB4bCRqrQ6QNUoiR1E0P3ED5YCM9T/aWEA+L5rnn/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bK1d6C0jE19WKmBSaO/2d6p1+5cncOp9eTer9pYa5Ui+pQgxVF9TZoK7KIm6Ui6dj
	 T/+V/C4+MDTpmpe4r7iGzMgMy+EOph3Di1V9lm5SfblwWlU1cPX0iHpgyyPUFm0N6Y
	 m0APhG0E0ET/NSTLgt3nqVGthJ+OFExgW5+qm35u7WsCOCf7t44KeebinjWkbVpYCk
	 pnFicP8xQvHNbVWOLHr/5JiYXXOeITccRAUm7gq2ZKEcoTb3fvYK0f1K8pKT9PQ7zC
	 lYCj4KlbLh43WhTKh0cuLeGpl7u6J5NJ+Gs97Gug8lqIvYQGlVLh4pGALRR2m4N+/s
	 MyOOr26God42w==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/7] sched_ext: Add the @sch parameter to __bstr_format()
Date: Mon, 22 Sep 2025 06:14:31 -1000
Message-ID: <20250922161436.358949-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922161436.358949-1-tj@kernel.org>
References: <20250922161436.358949-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for multiple scheduler support, add the @sch parameter to
__bstr_format() and update the callers to read $scx_root, verify that it's
not NULL and pass it in. The passed in @sch parameter is not used yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 560ac5a575bd..373146154829 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6063,8 +6063,9 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 
 __bpf_kfunc_end_defs();
 
-static s32 __bstr_format(u64 *data_buf, char *line_buf, size_t line_size,
-			 char *fmt, unsigned long long *data, u32 data__sz)
+static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
+			 size_t line_size, char *fmt, unsigned long long *data,
+			 u32 data__sz)
 {
 	struct bpf_bprintf_data bprintf_data = { .get_bin_args = true };
 	s32 ret;
@@ -6099,10 +6100,10 @@ static s32 __bstr_format(u64 *data_buf, char *line_buf, size_t line_size,
 	return ret;
 }
 
-static s32 bstr_format(struct scx_bstr_buf *buf,
+static s32 bstr_format(struct scx_sched *sch, struct scx_bstr_buf *buf,
 		       char *fmt, unsigned long long *data, u32 data__sz)
 {
-	return __bstr_format(buf->data, buf->line, sizeof(buf->line),
+	return __bstr_format(sch, buf->data, buf->line, sizeof(buf->line),
 			     fmt, data, data__sz);
 }
 
@@ -6121,10 +6122,13 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
 				   unsigned long long *data, u32 data__sz)
 {
+	struct scx_sched *sch;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
-	if (bstr_format(&scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
+	sch = rcu_dereference_bh(scx_root);
+	if (likely(sch) &&
+	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
 		scx_kf_exit(SCX_EXIT_UNREG_BPF, exit_code, "%s", scx_exit_bstr_buf.line);
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
 }
@@ -6141,10 +6145,13 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
 __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
 				    u32 data__sz)
 {
+	struct scx_sched *sch;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
-	if (bstr_format(&scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
+	sch = rcu_dereference_bh(scx_root);
+	if (likely(sch) &&
+	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
 		scx_kf_exit(SCX_EXIT_ERROR_BPF, 0, "%s", scx_exit_bstr_buf.line);
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
 }
@@ -6164,17 +6171,24 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
 __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 				   u32 data__sz)
 {
+	struct scx_sched *sch;
 	struct scx_dump_data *dd = &scx_dump_data;
 	struct scx_bstr_buf *buf = &dd->buf;
 	s32 ret;
 
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return;
+
 	if (raw_smp_processor_id() != dd->cpu) {
 		scx_kf_error("scx_bpf_dump() must only be called from ops.dump() and friends");
 		return;
 	}
 
 	/* append the formatted string to the line buf */
-	ret = __bstr_format(buf->data, buf->line + dd->cursor,
+	ret = __bstr_format(sch, buf->data, buf->line + dd->cursor,
 			    sizeof(buf->line) - dd->cursor, fmt, data, data__sz);
 	if (ret < 0) {
 		dump_line(dd->s, "%s[!] (\"%s\", %p, %u) failed to format (%d)",
-- 
2.51.0

