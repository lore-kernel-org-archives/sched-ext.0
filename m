Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0D3E1CFA
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353489; cv=fail; b=nhhg0wzf9nKefZPX86CQtgxBtnU5QWvyOberLXEBgvICQDyV7dKABP10k6gL0AyRnWhib3KA6axrbmyJAidGl7t0ZMOrPEKzhY93jwMC99d6wDEMGpmhPyY5e+3G3tKe52gsJUrddcmgXjTM85Kab5IDket4Jl5jfStfz3paJ8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353489; c=relaxed/simple;
	bh=K1N9DR8IOkUkVbu+q/xgDTq2RrXHtcZVW6MYlP1pw1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yg2C7g9fqnVCZkzPoz7lBJ2JIIW75mLHPffEfeu86+UHHjXvm5c3FFE7x7YAKpbL85wSa0VHuAlh32/Gyw5p7jm/Nb6iiaKWNTCdkk6U9dv0vwfhalbxxPDqfFEcNqifh4A08rmJ7k1TL1uPdXvSPDpaAKbtUKcSEcORqMxm35U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=h/NA15B2; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="h/NA15B2"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GB1plH3548657
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 08:31:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=VQHfLw3eW7W7ujIqv5saOoA1YUaI6oBIjgJLM8YTULo=; b=h/NA15B2IhFw
	wB8PBlb3jZs1LAAav1gVl1mUXB7t6XpSNvmEsOPqUzRi7FIlP960n2w+pLfj1ttD
	/6saoCef85WKDO1n1tSr8NKJtUQSfLbRe+E2WD9U/gnHrvYxb6bXLLTAAL70jrDs
	jcbdC5XztSf5tOELagPAdvdUEWoozzKGRJpxNGjNuqhNMQOYRCSjkwR59fJSbuFA
	wX87zGZz52hFnxLgf3IvZ9tSJ72GC8kjxyHZXMzn4VNM3FKfwFvsMAo5+g5elxb2
	USquzC62KzpnP94syuzGIEljJ8qgbbeTtU4jaylPWuiZdUS6sVpOywrYhjHxhosj
	ah4hHNAc4w==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84x2mcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 08:31:27 -0700 (PDT)
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso3234215f8f.0
        for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 08:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776353485; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZ/CW9TodmAvp/ZczZREEIvImotEaUlcDKfCTLepNIIhtsH75jlgvTkEimG0M61wCG
         SHWjyE/yruf0YlZk8PD0Wlwqwg3jOpSPwfl3yQ3aDk4Dt0izipzEz9l9hOdazR3CbGKK
         fTZufEleIaiD34QaiDo3ko2PoqKRKvkVDhmggVdel/llo1CH4TC2Ow5xCof/edoOhhe7
         jUPn1kQCxbJa69WkowqGGQ/sP3MLy8V4qUeHneuriKiHtjmeULG8iYlpdZ+1RhcZkrMz
         Wo2XW6IHN8yJ/eGpKJ1RvS6Bs2S6tYG81xO2liQnPHmgTIsUqxky6ar0Dce9vShKP8xX
         BJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=oPLZKI7D/Z3v0kz/cagkGvZsVVFLMB214zAbqT4YKmw=;
        fh=JxCU1HBFx1UeyljEhfFrULT217ZGMRIdeFjHq0m/LhE=;
        b=MGdq3QGyaX3oqX+oi3iW9ZmQzCo9d+WEqkE5DTfWjoMshDxJpZTzU7z1rpQV8UKELH
         iSxgglSts2MaIfm6QL5tiO+xywjZ4b1qAkIJJ/xw0CLrJ9H4KUHGkwMlsPCljd6vloTy
         CjPIx2i48XburcNBOm7RfpItEPLFXQkzTFPEGhtQcN7AfMJl3e5r1K2IlLl7szpKGy6v
         b2mzsp/8+UaAQknJYUva8lxQvUw4zwOc5aUExtgRfdMdJvC8eXW5DoWwiG34NBl2t/Ff
         AjwkFpUUTeN2oVKGEyOJwmYPZBNUYyp2viLFZqPltFJwZxyBRndlYrk6bYu6Jn60tzSi
         RvTw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353485; x=1776958285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPLZKI7D/Z3v0kz/cagkGvZsVVFLMB214zAbqT4YKmw=;
        b=PmYruo7aKQEFxxLTsBjzGs139oZbabnvfHRS0AvsmH0ITBtOT8ypstuQM2VaMq2SXU
         q2kBf5ek4Mpj4qhk8779x3Qw+DeFqE5uBn6SOG8dvMvaOKJZgqGEWgJSoNZnNB0jxsgJ
         ZKC1A/U6H7dNjti8na8LeihJoi5F4/pOQRhvnUVkQZpWWefucsJuuZrL/fxbaYjedaqc
         CMf/A66bZy9Yw161jruVEIYSy0dzc6LEBRLAAH+AfxC8syO7BjxvGlMUQGyF2FRh2jJj
         MZiW/4zegy8vHXszvvRx2Fyvq6WEW/H7RGFsn6lEZu5LM73cRqWKPbBdJG8Yw6P/X0Tq
         iOGg==
X-Forwarded-Encrypted: i=1; AFNElJ9gwTn+RYwGimmuQze5L95QRukfNsI9pJOvrZnsvFU1Ry+i9arGZ3+r2htnCjTW/f0R1kNpLlKCWXY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzUHrry0HqIZGE8Atn3NAJgVIdxjjiUnI6hgbG8gIg+NVAaG/OX
	RdZytshuawWK8Y3NdMMiS5EuUOj9CXMzDotqjsfMUew0mcPnZdL0v8KBl5XPDKSZpJlX67H6apP
	IZhfkJrXN9+8+fCobk/8/RyoBpsM3dGva9sQIPSvDLx41gxAChI5V2M3948g54L4HioxVr+bYhK
	UwFnmMweItCdbbZ4eJ3pU7G2NRvit+rNV1nqg=
X-Gm-Gg: AeBDieuI5tBn3KtLm5OcVm9sUuUQFXPQMASqHf0lC7/2P92XsLqj452+NmLy+5BXyT1
	/MLXS4CZ/e7ORmgET0nN7OCQN2aSJ2C/F1Di2910QhsfhdjWGe4wh8Y2pK6A3qg3JyU9X/GSPfM
	johcRQKLFpCglLU1Whg+sS3EGBO+s3o/xQWEstNNBvA5nEf1sQ7vqWOH9x5iKOT5FVsScm5eGI5
	9o3HAIgNJTA5AvVIE6XdLxgWc7EF+jj2+Nc17W+SXqBwWwElO24B0NwZlk3setg
X-Received: by 2002:a05:600c:1507:b0:485:3a27:a961 with SMTP id 5b1f17b1804b1-488d7f23b18mr200689645e9.0.1776353485075;
        Thu, 16 Apr 2026 08:31:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1507:b0:485:3a27:a961 with SMTP id
 5b1f17b1804b1-488d7f23b18mr200689025e9.0.1776353484449; Thu, 16 Apr 2026
 08:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260416081626.1285617-1-tj@kernel.org> <20260416081626.1285617-4-tj@kernel.org>
In-Reply-To: <20260416081626.1285617-4-tj@kernel.org>
From: Emil Tsalapatis <etsal@meta.com>
Date: Thu, 16 Apr 2026 08:31:12 -0700
X-Gm-Features: AQROBzD_mkSY-MFfxDMJ4PT8FCkK_MtGppxVxnl7U74w_A6RzIlXhPRadqSbOGQ
Message-ID: <CAMe2y=EWejtP8fQ0hvje472ZO_vMr4rn9GsgYM-b8UKmU_UFig@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched_ext: scx_qmap: move task_ctx into a BPF arena slab
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
        Changwoo Min <changwoo@igalia.com>,
        Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 3nKjvtDuoMtSQfk6vJVl6p1DagI-vGt4
X-Proofpoint-ORIG-GUID: 3nKjvtDuoMtSQfk6vJVl6p1DagI-vGt4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0NyBTYWx0ZWRfXyFU6hh7a3WAq
 9otGIlmLn6j/Uz7xK7e0UkjH1z2gVuf+aM2ADeeQ8/Uak7S5JR6I1E9KcsPreuu2Wosva0WjChf
 /zoXIrqGxIfdOs4Vbsp/Qq7l6aixaAXWtLB7DRci6s0sKLB4ZKRZFcphSnaABKl2feRKIHSQ2Cs
 FquC6wGgVRq9Sb94KVrZkvG5O6qZbAcy7E9xUkjl+gUgRto4SbyIyhgS1kSmMSGMIC5dicXTI63
 PQrTUUBAgVKEMVHN59Wt5792sQCUlaohI7tKqN2ecbQA07gJkH6aFduGw1ur1nRnqW9WAEmyXQD
 G+6Y25XKy3BlGBwGad5nYsqTiTLOZkooxlDwRk/MH21rwb77RP3Mc6bHGVeTruI5APIt5141nbf
 ra/elFdXU+Xedmi0N49Svl3r8Gw1GnoeXPwWho/RoVUq4l1xe/1HdO4KHQos4JSHRs2rq+gPojf
 wFBRZG/y8Ipz6+BMH9A==
X-Authority-Analysis: v=2.4 cv=aepRWxot c=1 sm=1 tr=0 ts=69e100cf cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=CWErhr8FAAAA:8 a=FUGtJdsc86X_b6lmtAcA:9 a=QEXdDO2ut3YA:10
 a=F7q00xkr9EfWfQvbdVXI:22 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01

On Thu, Apr 16, 2026 at 1:20=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> >
> Arena simplifies verification and allows more natural programming.
> Convert scx_qmap to arena as preparation for further sub-sched work.
>
> Allocate per-task context from an arena slab instead of storing it
> directly in task_storage. task_ctx_stor now holds an arena pointer to
> the task's slab entry. Free entries form a singly-linked list protected
> by bpf_res_spin_lock; slab exhaustion triggers scx_bpf_error().
>
> The slab size is configurable via the new -N option (default 16384).
>
> Also add bpf_res_spin_lock/unlock declarations to common.bpf.h.
>
> Scheduling logic unchanged.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

One nit, since we never have non-arena task_ctxs we can do

typedef struct task_ctx __arena task_ctx;

to avoid annotating every instance.

>  tools/sched_ext/include/scx/common.bpf.h |   4 +
>  tools/sched_ext/scx_qmap.bpf.c           | 178 ++++++++++++++++++-----
>  tools/sched_ext/scx_qmap.c               |   9 +-
>  tools/sched_ext/scx_qmap.h               |   7 +
>  4 files changed, 159 insertions(+), 39 deletions(-)
>
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index 19459dedde41..35fc62556241 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -526,6 +526,10 @@ static inline bool is_migration_disabled(const struc=
t task_struct *p)
>  void bpf_rcu_read_lock(void) __ksym;
>  void bpf_rcu_read_unlock(void) __ksym;
>
> +/* resilient qspinlock */
> +int bpf_res_spin_lock(struct bpf_res_spin_lock *lock) __ksym __weak;
> +void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock) __ksym __weak;
> +
>  /*
>   * Time helpers, most of which are from jiffies.h.
>   */
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 0f8fbb6d0bc2..e071969c8f32 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -49,6 +49,7 @@ const volatile s32 disallow_tgid;
>  const volatile bool suppress_dump;
>  const volatile bool always_enq_immed;
>  const volatile u32 immed_stress_nth;
> +const volatile u32 max_tasks;
>
>  UEI_DEFINE(uei);
>
> @@ -117,20 +118,43 @@ static const u32 qidx_to_cpuperf_target[] =3D {
>   * and used when comparing two tasks for ordering. See qmap_core_sched_b=
efore().
>   */
>
> -/* Per-task scheduling context */
> +/*
> + * Per-task scheduling context. Allocated from the qa.task_ctxs[] slab in
> + * arena. While the task is alive the entry is referenced from task_ctx_=
stor;
> + * while it's free the entry sits on the free list singly-linked through
> + * @next_free.
> + */
>  struct task_ctx {
> -       bool    force_local;    /* Dispatch directly to local_dsq */
> -       bool    highpri;
> -       u64     core_sched_seq;
> +       struct task_ctx __arena *next_free;     /* only valid on free lis=
t */
> +       bool                    force_local;    /* Dispatch directly to l=
ocal_dsq */
> +       bool                    highpri;
> +       u64                     core_sched_seq;
> +};
> +
> +/* Holds an arena pointer to the task's slab entry. */
> +struct task_ctx_stor_val {
> +       struct task_ctx __arena *taskc;
>  };
>
>  struct {
>         __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>         __uint(map_flags, BPF_F_NO_PREALLOC);
>         __type(key, int);
> -       __type(value, struct task_ctx);
> +       __type(value, struct task_ctx_stor_val);
>  } task_ctx_stor SEC(".maps");
>
> +/* Protects the task_ctx slab free list. */
> +__hidden struct bpf_res_spin_lock qa_task_lock SEC(".data.qa_task_lock");
> +
> +static int qmap_spin_lock(struct bpf_res_spin_lock *lock)
> +{
> +       if (bpf_res_spin_lock(lock)) {
> +               scx_bpf_error("res_spin_lock failed");
> +               return -EBUSY;
> +       }
> +       return 0;
> +}
> +
>  static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
>  {
>         s32 cpu;
> @@ -148,21 +172,34 @@ static s32 pick_direct_dispatch_cpu(struct task_str=
uct *p, s32 prev_cpu)
>         return -1;
>  }
>
> -static struct task_ctx *lookup_task_ctx(struct task_struct *p)
> +/*
> + * Force a reference to the arena map. The verifier associates an arena =
with
> + * a program by finding an LD_IMM64 instruction that loads the arena's B=
PF
> + * map; programs that only use arena pointers returned from task-local
> + * storage (like qmap_select_cpu) never reference @arena directly. Witho=
ut
> + * this, the verifier rejects addr_space_cast with "addr_space_cast insn
> + * can only be used in a program that has an associated arena".
> + */
> +#define QMAP_TOUCH_ARENA() do { asm volatile("" :: "r"(&arena)); } while=
 (0)
> +

Really nice that this works when placed as a macro.

> +static struct task_ctx __arena *lookup_task_ctx(struct task_struct *p)
>  {
> -       struct task_ctx *taskc;
> +       struct task_ctx_stor_val *v;
> +
> +       QMAP_TOUCH_ARENA();
>
> -       if (!(taskc =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0))) {
> +       v =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> +       if (!v || !v->taskc) {
>                 scx_bpf_error("task_ctx lookup failed");
>                 return NULL;
>         }
> -       return taskc;
> +       return v->taskc;
>  }
>
>  s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
>                    s32 prev_cpu, u64 wake_flags)
>  {
> -       struct task_ctx *taskc;
> +       struct task_ctx __arena *taskc;
>         s32 cpu;
>
>         if (!(taskc =3D lookup_task_ctx(p)))
> @@ -199,7 +236,7 @@ static int weight_to_idx(u32 weight)
>  void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
>  {
>         static u32 user_cnt, kernel_cnt;
> -       struct task_ctx *taskc;
> +       struct task_ctx __arena *taskc;
>         u32 pid =3D p->pid;
>         int idx =3D weight_to_idx(p->scx.weight);
>         void *ring;
> @@ -321,7 +358,7 @@ void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct =
*p, u64 deq_flags)
>  static void update_core_sched_head_seq(struct task_struct *p)
>  {
>         int idx =3D weight_to_idx(p->scx.weight);
> -       struct task_ctx *taskc;
> +       struct task_ctx __arena *taskc;
>
>         if ((taskc =3D lookup_task_ctx(p)))
>                 qa.core_sched_head_seqs[idx] =3D taskc->core_sched_seq;
> @@ -345,7 +382,7 @@ static bool dispatch_highpri(bool from_timer)
>         /* scan SHARED_DSQ and move highpri tasks to HIGHPRI_DSQ */
>         bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
>                 static u64 highpri_seq;
> -               struct task_ctx *taskc;
> +               struct task_ctx __arena *taskc;
>
>                 if (!(taskc =3D lookup_task_ctx(p)))
>                         return false;
> @@ -396,7 +433,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct ta=
sk_struct *prev)
>  {
>         struct task_struct *p;
>         struct cpu_ctx __arena *cpuc;
> -       struct task_ctx *taskc;
> +       struct task_ctx __arena *taskc;
>         u32 batch =3D dsp_batch ?: 1;
>         void *fifo;
>         s32 i, pid;
> @@ -440,7 +477,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct ta=
sk_struct *prev)
>
>                 /* Dispatch or advance. */
>                 bpf_repeat(BPF_MAX_LOOPS) {
> -                       struct task_ctx *taskc;
> +                       struct task_ctx __arena *taskc;
>
>                         if (bpf_map_pop_elem(fifo, &pid))
>                                 break;
> @@ -529,11 +566,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct t=
ask_struct *prev)
>          * if the task were enqueued and dispatched immediately.
>          */
>         if (prev) {
> -               taskc =3D bpf_task_storage_get(&task_ctx_stor, prev, 0, 0=
);
> -               if (!taskc) {
> -                       scx_bpf_error("task_ctx lookup failed");
> +               taskc =3D lookup_task_ctx(prev);
> +               if (!taskc)
>                         return;
> -               }
>
>                 taskc->core_sched_seq =3D
>                         qa.core_sched_tail_seqs[weight_to_idx(prev->scx.w=
eight)]++;
> @@ -564,14 +599,12 @@ void BPF_STRUCT_OPS(qmap_tick, struct task_struct *=
p)
>  static s64 task_qdist(struct task_struct *p)
>  {
>         int idx =3D weight_to_idx(p->scx.weight);
> -       struct task_ctx *taskc;
> +       struct task_ctx __arena *taskc;
>         s64 qdist;
>
> -       taskc =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> -       if (!taskc) {
> -               scx_bpf_error("task_ctx lookup failed");
> +       taskc =3D lookup_task_ctx(p);
> +       if (!taskc)
>                 return 0;
> -       }
>
>         qdist =3D taskc->core_sched_seq - qa.core_sched_head_seqs[idx];
>
> @@ -606,21 +639,64 @@ bool BPF_STRUCT_OPS(qmap_core_sched_before,
>   * tasks when a higher-priority scheduling class takes the CPU.
>   */
>
> -s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
> -                  struct scx_init_task_args *args)
> +s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct task_struct *p,
> +                            struct scx_init_task_args *args)
>  {
> +       struct task_ctx_stor_val *v;
> +       struct task_ctx __arena *taskc;
> +
>         if (p->tgid =3D=3D disallow_tgid)
>                 p->scx.disallow =3D true;
>
> -       /*
> -        * @p is new. Let's ensure that its task_ctx is available. We can=
 sleep
> -        * in this function and the following will automatically use GFP_=
KERNEL.
> -        */
> -       if (bpf_task_storage_get(&task_ctx_stor, p, 0,
> -                                BPF_LOCAL_STORAGE_GET_F_CREATE))
> -               return 0;
> -       else
> +       /* pop a slab entry off the free list */
> +       if (qmap_spin_lock(&qa_task_lock))
> +               return -EBUSY;
> +       taskc =3D qa.task_free_head;
> +       if (taskc)
> +               qa.task_free_head =3D taskc->next_free;
> +       bpf_res_spin_unlock(&qa_task_lock);
> +       if (!taskc) {
> +               scx_bpf_error("task_ctx slab exhausted (max_tasks=3D%u)",=
 max_tasks);
> +               return -ENOMEM;
> +       }
> +
> +       taskc->next_free =3D NULL;
> +       taskc->force_local =3D false;
> +       taskc->highpri =3D false;
> +       taskc->core_sched_seq =3D 0;
> +
> +       v =3D bpf_task_storage_get(&task_ctx_stor, p, NULL,
> +                                BPF_LOCAL_STORAGE_GET_F_CREATE);
> +       if (!v) {
> +               /* push back to the free list */
> +               if (!qmap_spin_lock(&qa_task_lock)) {
> +                       taskc->next_free =3D qa.task_free_head;
> +                       qa.task_free_head =3D taskc;
> +                       bpf_res_spin_unlock(&qa_task_lock);
> +               }
>                 return -ENOMEM;
> +       }
> +       v->taskc =3D taskc;
> +       return 0;
> +}
> +
> +void BPF_STRUCT_OPS(qmap_exit_task, struct task_struct *p,
> +                   struct scx_exit_task_args *args)
> +{
> +       struct task_ctx_stor_val *v;
> +       struct task_ctx __arena *taskc;
> +
> +       v =3D bpf_task_storage_get(&task_ctx_stor, p, NULL, 0);
> +       if (!v || !v->taskc)
> +               return;
> +       taskc =3D v->taskc;
> +       v->taskc =3D NULL;
> +
> +       if (qmap_spin_lock(&qa_task_lock))
> +               return;
> +       taskc->next_free =3D qa.task_free_head;
> +       qa.task_free_head =3D taskc;
> +       bpf_res_spin_unlock(&qa_task_lock);
>  }
>
>  void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
> @@ -675,12 +751,17 @@ void BPF_STRUCT_OPS(qmap_dump_cpu, struct scx_dump_=
ctx *dctx, s32 cpu, bool idle
>
>  void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct ta=
sk_struct *p)
>  {
> -       struct task_ctx *taskc;
> +       struct task_ctx_stor_val *v;
> +       struct task_ctx __arena *taskc;
> +
> +       QMAP_TOUCH_ARENA();
>
>         if (suppress_dump)
>                 return;
> -       if (!(taskc =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0)))
> +       v =3D bpf_task_storage_get(&task_ctx_stor, p, NULL, 0);
> +       if (!v || !v->taskc)
>                 return;
> +       taskc =3D v->taskc;
>
>         scx_bpf_dump("QMAP: force_local=3D%d core_sched_seq=3D%llu",
>                      taskc->force_local, taskc->core_sched_seq);
> @@ -915,10 +996,32 @@ static int lowpri_timerfn(void *map, int *key, stru=
ct bpf_timer *timer)
>
>  s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
>  {
> -       u32 key =3D 0;
> +       struct task_ctx __arena *slab;
> +       u32 nr_pages, key =3D 0, i;
>         struct bpf_timer *timer;
>         s32 ret;
>
> +       /*
> +        * Allocate the task_ctx slab in arena and thread the entire slab=
 onto
> +        * the free list. max_tasks is set by userspace before load.
> +        */
> +       if (!max_tasks) {
> +               scx_bpf_error("max_tasks must be > 0");
> +               return -EINVAL;
> +       }
> +
> +       nr_pages =3D (max_tasks * sizeof(struct task_ctx) + PAGE_SIZE - 1=
) / PAGE_SIZE;
> +       slab =3D bpf_arena_alloc_pages(&arena, NULL, nr_pages, NUMA_NO_NO=
DE, 0);
> +       if (!slab) {
> +               scx_bpf_error("failed to allocate task_ctx slab");
> +               return -ENOMEM;
> +       }
> +       qa.task_ctxs =3D slab;
> +
> +       bpf_for(i, 0, max_tasks)
> +               slab[i].next_free =3D (i + 1 < max_tasks) ? &slab[i + 1] =
: NULL;
> +       qa.task_free_head =3D &slab[0];
> +
>         if (print_msgs && !sub_cgroup_id)
>                 print_cpus();
>
> @@ -1005,6 +1108,7 @@ SCX_OPS_DEFINE(qmap_ops,
>                .tick                    =3D (void *)qmap_tick,
>                .core_sched_before       =3D (void *)qmap_core_sched_befor=
e,
>                .init_task               =3D (void *)qmap_init_task,
> +              .exit_task               =3D (void *)qmap_exit_task,
>                .dump                    =3D (void *)qmap_dump,
>                .dump_cpu                =3D (void *)qmap_dump_cpu,
>                .dump_task               =3D (void *)qmap_dump_task,
> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index 8844499c14c4..4bdcc4bc5fbd 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -23,12 +23,13 @@ const char help_fmt[] =3D
>  "See the top-level comment in .bpf.c for more details.\n"
>  "\n"
>  "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b=
 COUNT]\n"
> -"       [-P] [-M] [-H] [-d PID] [-D LEN] [-S] [-p] [-I] [-F COUNT] [-v]\=
n"
> +"       [-N COUNT] [-P] [-M] [-H] [-d PID] [-D LEN] [-S] [-p] [-I] [-F C=
OUNT] [-v]\n"
>  "\n"
>  "  -s SLICE_US   Override slice duration\n"
>  "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
>  "  -t COUNT      Stall every COUNT'th user thread\n"
>  "  -T COUNT      Stall every COUNT'th kernel thread\n"
> +"  -N COUNT      Size of the task_ctx arena slab (default 16384)\n"
>  "  -l COUNT      Trigger dispatch infinite looping after COUNT dispatche=
s\n"
>  "  -b COUNT      Dispatch upto COUNT tasks together\n"
>  "  -P            Print out DSQ content and event counters to trace_pipe =
every second\n"
> @@ -73,8 +74,9 @@ int main(int argc, char **argv)
>         skel =3D SCX_OPS_OPEN(qmap_ops, scx_qmap);
>
>         skel->rodata->slice_ns =3D __COMPAT_ENUM_OR_ZERO("scx_public_cons=
ts", "SCX_SLICE_DFL");
> +       skel->rodata->max_tasks =3D 16384;
>
> -       while ((opt =3D getopt(argc, argv, "s:e:t:T:l:b:PMHc:d:D:SpIF:vh"=
)) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:v=
h")) !=3D -1) {
>                 switch (opt) {
>                 case 's':
>                         skel->rodata->slice_ns =3D strtoull(optarg, NULL,=
 0) * 1000;
> @@ -94,6 +96,9 @@ int main(int argc, char **argv)
>                 case 'b':
>                         skel->rodata->dsp_batch =3D strtoul(optarg, NULL,=
 0);
>                         break;
> +               case 'N':
> +                       skel->rodata->max_tasks =3D strtoul(optarg, NULL,=
 0);
> +                       break;
>                 case 'P':
>                         skel->rodata->print_dsqs_and_events =3D true;
>                         break;
> diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
> index 52153230bfce..c183d82632b3 100644
> --- a/tools/sched_ext/scx_qmap.h
> +++ b/tools/sched_ext/scx_qmap.h
> @@ -34,6 +34,9 @@ struct cpu_ctx {
>         __u32 cpuperf_target;
>  };
>
> +/* Opaque to userspace; defined in scx_qmap.bpf.c. */
> +struct task_ctx;
> +
>  struct qmap_arena {
>         /* userspace-visible stats */
>         __u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cp=
u0;
> @@ -52,6 +55,10 @@ struct qmap_arena {
>         __u64 core_sched_tail_seqs[5];
>
>         struct cpu_ctx cpu_ctxs[SCX_QMAP_MAX_CPUS];
> +
> +       /* task_ctx slab; allocated and threaded by qmap_init() */
> +       struct task_ctx __arena *task_ctxs;
> +       struct task_ctx __arena *task_free_head;
>  };
>
>  #endif /* __SCX_QMAP_H */
> --
> 2.53.0
>
>
