Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9C39098D
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353344; cv=fail; b=fnA5bvdvYYOdg3R9fJ3Sp/Lk+OGaS9rV0e6yNTubZP+mfEbyo3ByTshojaAFM42U8EGYadM+5fM5VyKYwJSGH9SPkCn6C/NeFYIM3uhVgrqkgz91rUu4NL8WWo/d+veVXPYEdaircBouoqYdtYbaAStHtxFnhfemB/IRP5F4Td0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353344; c=relaxed/simple;
	bh=qJe0NaWagkA9+JhQb0BGGk63UjkJv+em2UfFFWNqbjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uj7MMZ11FPcFJc+TahFLC7S78/gcr2cfkW3OPG8ThwS7nc8xj4bxBk01lBry8OdWXhq+1OyK9nu5YvRB3pKBmFGDQwyKGyss0MUDCNxwRquU+ZXHROUX2uWLTEQCKnxa4zZZSbWRoCLvokyG7a2JIM3Cy6hoyQEYAPvDU8Y/+zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DsGB3Tzq; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DsGB3Tzq"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G2a4g62435765
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 08:29:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=yC1Q41m8mP0u0pnZU+jF9Gq4jFlxlZ79PSJI5I7o+qU=; b=DsGB3Tzq7Je5
	vKN6l2c7cXFILFXlZsGtHrlYqZD/SGwUgJJEToe2IW7QjltsB3+cYlN/ipVodXco
	v3JI+HATVGb6KJu4L7FhsoAR4rv82pC55tcanhIwTDpKYf5cpilVR8t+sMb3Wvtf
	4iOpMpSKS2MK8Be3GgJduODJwlZAACFmaQYdcu6Dk8THNBwRMVEXHzG1PwKMVlZW
	JrZiZOnQFtU8nibW/kW/pXqoMPB/xxI+jqOGzDuQmzpASCQlUln5Jme8DfxqY1yi
	UQCdGNFtNI3/I1oP2dy04PhzmEEzR9yl9p55e2tMKN1i62FijUqXsKEIZFONDnws
	ebx1xXSDKA==
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh864jrsy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 08:29:01 -0700 (PDT)
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c213b485so61941195e9.2
        for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 08:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776353340; cv=none;
        d=google.com; s=arc-20240605;
        b=g9x2kvyjLsSvd1QL+hWRZqACZkUQ4UDZuRKM2mRpXwcTHjhDVZySGKQ01IZBRxff/3
         XejYh2oMjqyEjxQPIPqza/cjz0nlGxI7mXG4FoaADiFVB8pZqxJwQVvaKxjF7DYEx4pD
         KjggysqUFEwP+3dwYhb2/S6LYM2J99Wqdkzrsv3ElJFh1D/vizmJN+BOE0DE6KIIqv13
         JzPC6oUkI6dzA5ur1f3RHSqC1m9Qb7Kb80M2qKnJ/kvuw+GtNY5IAS8LTTGnexviHQUi
         5l8QRDLd4e/XIKq/sCZBbuDwY+kYxEjGUKdnDvBoULOLdiviEc1Pw0OQBiLIgpInxAyN
         sJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=B6HIx1G8DCWQOBzzLaP2s73BJd2FUe6w7ma7Pwwtg1E=;
        fh=xc+TNgpJiKr1q4NrApni1+BCBWH3X40WIWVHpFFo6ds=;
        b=CEriaqX/JB9nDAupjcPXmqqjF4d0XeipITMzqIK1ICRAtE6rU8m4K3QRy22bxFycUm
         OA1wTuz5XCHf8t2A1wG38JixfmcSBIZNjD/ho6dq/dm9Rv6ibEJMmMR+ffE3bcvwEJPE
         /B4hEfbazxVwdPy16k+aq4SaoKYVyHuzyJwqMF4m1J5EfaV1Kr2hfk+ig85/dJGp+sj3
         Ak9kNCxukdtfnKbEmL1h7shbF4l159A/IvpKCHQYUzaMsGaGGdID35qDZWlpyZwZAIG9
         18ca2FsRETw/iErMNWXGQxtV4Yk2IWQ11EqHBPNbkztPPSK8Q6kKpb9apFWn8RmdG/fu
         jGsA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353340; x=1776958140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B6HIx1G8DCWQOBzzLaP2s73BJd2FUe6w7ma7Pwwtg1E=;
        b=ly5CB0Sok+2kXYmwbTGF1CndAYJEMiGctR9fzODRUmVF3oAHfGUFhTk3pPv7Y8pV43
         U27CpZ1579bQWWfk8EcZQiJV9QkhwRTzKpf3XQvxP5HoxV2p7oW69qLpG9DHKbArzgVW
         1jU8W7AMA2oCAEtUpm75lhn3NSp3xncHObioP7ZOSlOYbYB59km6fAxK2at6mC8aD6na
         6VpdeHXpn7w7tKKEP2l1vzqkPcr0n8YsI6XwDM/wsDZZl99dj+7UJ9FWAsdSyYsRZXyE
         QFRHCq5YCQp21012g2yHKv+p6WpzklljDvcZ/sYHAkiOEfIvRRBSpzHEuszl6rRqDy0p
         IXZg==
X-Forwarded-Encrypted: i=1; AFNElJ9V1d5e7+Cr3Og6Y3z3O+mSFB93R3M9YqNBoaKQC3nB8EiX+QPcdVZrVPJgQ6wXBBd181e51+6KwoY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzbQFhjtwiJhvhdG/MGI8XyZ//VnnezhfeiFHMRFOiCiTVIiM16
	WSfGlgAMJQA65E2kW5+6eYsMSr9rvbIdQ7sPXT5DZk6MIpQIeO+FypqEmqbjFo7tU1LhhiqJ5V5
	Z7pk2O1VuCsNmnsiItUPLKAfNRjyNEFSuUruivJNpAJTHAY4ngPC4Ps2gO1tjg3L9+KYYlI7q4g
	4oDhaendnItZCc/xE0u95B5KVsp9k/6mAeErA=
X-Gm-Gg: AeBDiev7D2gInrHhIF/c8EpKR4gFX1yrCGiTcQ2HoFK6rowzYohHc8q5OQL/VM4SvfE
	C6hK/aZaKYVy1Ptvde9GhA2V5kTAnX17ATKDevSLKY3zHtbAU9qnd2sRYps4WRoL8J/CB48Qj6H
	PgPpPAzJHRCT2dfewfJJYADsZTSLul8D3o4WmKl7NxLzdGVZZ5j7dSXCFVfN2ph9jXBA2Igfpij
	aIEius2WAYpdEJRC4OH8+r90xSiaL1yMkYD9cauncR4lv2pbQCntJUA30bSv1r0
X-Received: by 2002:a05:600c:674f:b0:488:a82f:bb9b with SMTP id 5b1f17b1804b1-488d68cb47amr382982435e9.30.1776353340010;
        Thu, 16 Apr 2026 08:29:00 -0700 (PDT)
X-Received: by 2002:a05:600c:674f:b0:488:a82f:bb9b with SMTP id
 5b1f17b1804b1-488d68cb47amr382981705e9.30.1776353339358; Thu, 16 Apr 2026
 08:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260416081626.1285617-1-tj@kernel.org> <20260416081626.1285617-3-tj@kernel.org>
In-Reply-To: <20260416081626.1285617-3-tj@kernel.org>
From: Emil Tsalapatis <etsal@meta.com>
Date: Thu, 16 Apr 2026 08:28:47 -0700
X-Gm-Features: AQROBzA4H_GAnja1uleDKrxxCHn_63F-4zmxzDvTMzHouKqtQZ66K11KoEbL6Nw
Message-ID: <CAMe2y=GpzfsEC61VJSfLBBNjR+gbFDm41pjFJGz02hg4+8C0wQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched_ext: scx_qmap: move globals and cpu_ctx into a
 BPF arena map
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
        Changwoo Min <changwoo@igalia.com>,
        Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GKY41ONK c=1 sm=1 tr=0 ts=69e1003e cx=c_pps
 a=IwH782EDBk/vqbJ9rM8UFw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=VwQbUJbxAAAA:8 a=CWErhr8FAAAA:8 a=DIKSa76ZwRCfwPHaqN0A:9 a=QEXdDO2ut3YA:10
 a=Ng9YvVcppn9CIdWre3nD:22 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-GUID: Mp9vRG3cLgLTjUlWudsuvKvRf2YLkMaP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0NyBTYWx0ZWRfX+xe61LTRXTko
 PyuV+qQdy/ky8zfJ/AlB1xtWBG0FyYa3e7au683SDFjdhGj+yS46m37MZyP3zfe4EBoVsKoRsQh
 jDMxSDDYGqSfy+W+ypl5F+oCQtbTM6kbBcR+MS2ewykygPSwJ9/WE8ihJfbTe2ywXfizbpM1sRP
 EvMZr6KGNw5Ksm7uiDMj9E+htosGAJNqKrcC7uhTOFskMDjQsEXpDALZ+VP840MJ/eWqHV0WzFM
 AQsUuHkXTK2BLr8DJuQoLaS/TI7WBPi3DoOC3DdDTChJO+bfsIgT4ocTtEpMaxFnr48wq/W7ZfA
 8H9xh1e8k6s5fZyIex4pL1SfF5PMFR9e2O8du3qwlrfV+NlFYiQ9/0Rd5Z7oRAJk9IhMjJ4g5id
 XwXxpTyaHPegMjqcomYNpBYRu2c2qaAEaU7mjlpn3hHD+Xhd2Ta8Dv6CvpSWX8FmG3S1k9V6lEP
 F3pph9ZBkeP/USJuUTw==
X-Proofpoint-ORIG-GUID: Mp9vRG3cLgLTjUlWudsuvKvRf2YLkMaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01

On Thu, Apr 16, 2026 at 1:20=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> >
> Arena simplifies verification and allows more natural programming.
> Convert scx_qmap to arena as preparation for further sub-sched work.
>
> Move mutable scheduler state from BSS globals and a percpu array map
> into a single BPF arena map. A shared struct qmap_arena is declared as
> an __arena global so BPF accesses it directly and userspace reaches it
> through skel->arena->qa.
>
> Scheduling logic unchanged; only memory backing changes.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  tools/sched_ext/scx_qmap.bpf.c | 152 ++++++++++++++-------------------
>  tools/sched_ext/scx_qmap.c     |  45 +++++-----
>  tools/sched_ext/scx_qmap.h     |  57 +++++++++++++
>  3 files changed, 147 insertions(+), 107 deletions(-)
>  create mode 100644 tools/sched_ext/scx_qmap.h
>
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index a18234f3c27a..0f8fbb6d0bc2 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -22,6 +22,8 @@
>   */
>  #include <scx/common.bpf.h>
>
> +#include "scx_qmap.h"
> +
>  enum consts {
>         ONE_SEC_IN_NS           =3D 1000000000,
>         ONE_MSEC_IN_NS          =3D 1000000,
> @@ -48,14 +50,26 @@ const volatile bool suppress_dump;
>  const volatile bool always_enq_immed;
>  const volatile u32 immed_stress_nth;
>
> -u64 nr_highpri_queued;
> -u32 test_error_cnt;
> -
> -#define MAX_SUB_SCHEDS         8
> -u64 sub_sched_cgroup_ids[MAX_SUB_SCHEDS];
> -
>  UEI_DEFINE(uei);
>
> +/*
> + * All mutable scheduler state - per-cpu context, stats counters, core-s=
ched
> + * sequence numbers, sub-sched cgroup ids - lives in this single BPF are=
na map.
> + * Userspace reaches it via skel->arena->qa.
> + */
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARENA);
> +       __uint(map_flags, BPF_F_MMAPABLE);
> +       __uint(max_entries, 1 << 16);           /* upper bound in pages */

I assume this is picked to handle 64K pages on ARM.

> +#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
> +       __ulong(map_extra, 0x1ull << 32);       /* user/BPF mmap base */
> +#else
> +       __ulong(map_extra, 0x1ull << 44);
> +#endif
> +} arena SEC(".maps");
> +
> +struct qmap_arena __arena qa;
> +
>  struct qmap {
>         __uint(type, BPF_MAP_TYPE_QUEUE);
>         __uint(max_entries, 4096);
> @@ -102,8 +116,6 @@ static const u32 qidx_to_cpuperf_target[] =3D {
>   * task's seq and the associated queue's head seq is called the queue di=
stance
>   * and used when comparing two tasks for ordering. See qmap_core_sched_b=
efore().
>   */
> -static u64 core_sched_head_seqs[5];
> -static u64 core_sched_tail_seqs[5];
>
>  /* Per-task scheduling context */
>  struct task_ctx {
> @@ -119,27 +131,6 @@ struct {
>         __type(value, struct task_ctx);
>  } task_ctx_stor SEC(".maps");
>
> -struct cpu_ctx {
> -       u64     dsp_idx;        /* dispatch index */
> -       u64     dsp_cnt;        /* remaining count */
> -       u32     avg_weight;
> -       u32     cpuperf_target;
> -};
> -
> -struct {
> -       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> -       __uint(max_entries, 1);
> -       __type(key, u32);
> -       __type(value, struct cpu_ctx);
> -} cpu_ctx_stor SEC(".maps");
> -
> -/* Statistics */
> -u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cpu0, nr_de=
queued, nr_ddsp_from_enq;
> -u64 nr_core_sched_execed;
> -u64 nr_expedited_local, nr_expedited_remote, nr_expedited_lost, nr_exped=
ited_from_timer;
> -u32 cpuperf_min, cpuperf_avg, cpuperf_max;
> -u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
> -
>  static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
>  {
>         s32 cpu;
> @@ -215,9 +206,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>         s32 cpu;
>
>         if (enq_flags & SCX_ENQ_REENQ) {
> -               __sync_fetch_and_add(&nr_reenqueued, 1);
> +               __sync_fetch_and_add(&qa.nr_reenqueued, 1);
>                 if (scx_bpf_task_cpu(p) =3D=3D 0)
> -                       __sync_fetch_and_add(&nr_reenqueued_cpu0, 1);
> +                       __sync_fetch_and_add(&qa.nr_reenqueued_cpu0, 1);
>         }
>
>         if (p->flags & PF_KTHREAD) {
> @@ -228,7 +219,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>                         return;
>         }
>
> -       if (test_error_cnt && !--test_error_cnt)
> +       if (qa.test_error_cnt && !--qa.test_error_cnt)
>                 scx_bpf_error("test triggering error");
>
>         if (!(taskc =3D lookup_task_ctx(p)))
> @@ -238,7 +229,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>          * All enqueued tasks must have their core_sched_seq updated for =
correct
>          * core-sched ordering. Also, take a look at the end of qmap_disp=
atch().
>          */
> -       taskc->core_sched_seq =3D core_sched_tail_seqs[idx]++;
> +       taskc->core_sched_seq =3D qa.core_sched_tail_seqs[idx]++;
>
>         /*
>          * IMMED stress testing: Every immed_stress_nth'th enqueue, dispa=
tch
> @@ -276,7 +267,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>         /* if select_cpu() wasn't called, try direct dispatch */
>         if (!__COMPAT_is_enq_cpu_selected(enq_flags) &&
>             (cpu =3D pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >=
=3D 0) {
> -               __sync_fetch_and_add(&nr_ddsp_from_enq, 1);
> +               __sync_fetch_and_add(&qa.nr_ddsp_from_enq, 1);
>                 scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, e=
nq_flags);
>                 return;
>         }
> @@ -311,9 +302,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>
>         if (highpri_boosting && p->scx.weight >=3D HIGHPRI_WEIGHT) {
>                 taskc->highpri =3D true;
> -               __sync_fetch_and_add(&nr_highpri_queued, 1);
> +               __sync_fetch_and_add(&qa.nr_highpri_queued, 1);
>         }
> -       __sync_fetch_and_add(&nr_enqueued, 1);
> +       __sync_fetch_and_add(&qa.nr_enqueued, 1);
>  }
>
>  /*
> @@ -322,9 +313,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>   */
>  void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags)
>  {
> -       __sync_fetch_and_add(&nr_dequeued, 1);
> +       __sync_fetch_and_add(&qa.nr_dequeued, 1);
>         if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC)
> -               __sync_fetch_and_add(&nr_core_sched_execed, 1);
> +               __sync_fetch_and_add(&qa.nr_core_sched_execed, 1);
>  }
>
>  static void update_core_sched_head_seq(struct task_struct *p)
> @@ -333,7 +324,7 @@ static void update_core_sched_head_seq(struct task_st=
ruct *p)
>         struct task_ctx *taskc;
>
>         if ((taskc =3D lookup_task_ctx(p)))
> -               core_sched_head_seqs[idx] =3D taskc->core_sched_seq;
> +               qa.core_sched_head_seqs[idx] =3D taskc->core_sched_seq;
>  }
>
>  /*
> @@ -384,14 +375,14 @@ static bool dispatch_highpri(bool from_timer)
>                                      SCX_ENQ_PREEMPT)) {
>                         if (cpu =3D=3D this_cpu) {
>                                 dispatched =3D true;
> -                               __sync_fetch_and_add(&nr_expedited_local,=
 1);
> +                               __sync_fetch_and_add(&qa.nr_expedited_loc=
al, 1);
>                         } else {
> -                               __sync_fetch_and_add(&nr_expedited_remote=
, 1);
> +                               __sync_fetch_and_add(&qa.nr_expedited_rem=
ote, 1);
>                         }
>                         if (from_timer)
> -                               __sync_fetch_and_add(&nr_expedited_from_t=
imer, 1);
> +                               __sync_fetch_and_add(&qa.nr_expedited_fro=
m_timer, 1);
>                 } else {
> -                       __sync_fetch_and_add(&nr_expedited_lost, 1);
> +                       __sync_fetch_and_add(&qa.nr_expedited_lost, 1);
>                 }
>
>                 if (dispatched)
> @@ -404,19 +395,19 @@ static bool dispatch_highpri(bool from_timer)
>  void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
>  {
>         struct task_struct *p;
> -       struct cpu_ctx *cpuc;
> +       struct cpu_ctx __arena *cpuc;
>         struct task_ctx *taskc;
> -       u32 zero =3D 0, batch =3D dsp_batch ?: 1;
> +       u32 batch =3D dsp_batch ?: 1;
>         void *fifo;
>         s32 i, pid;
>
>         if (dispatch_highpri(false))
>                 return;
>
> -       if (!nr_highpri_queued && scx_bpf_dsq_move_to_local(SHARED_DSQ, 0=
))
> +       if (!qa.nr_highpri_queued && scx_bpf_dsq_move_to_local(SHARED_DSQ=
, 0))
>                 return;
>
> -       if (dsp_inf_loop_after && nr_dispatched > dsp_inf_loop_after) {
> +       if (dsp_inf_loop_after && qa.nr_dispatched > dsp_inf_loop_after) {
>                 /*
>                  * PID 2 should be kthreadd which should mostly be idle a=
nd off
>                  * the scheduler. Let's keep dispatching it to force the =
kernel
> @@ -430,10 +421,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct t=
ask_struct *prev)
>                 }
>         }
>
> -       if (!(cpuc =3D bpf_map_lookup_elem(&cpu_ctx_stor, &zero))) {
> -               scx_bpf_error("failed to look up cpu_ctx");
> -               return;
> -       }
> +       cpuc =3D &qa.cpu_ctxs[bpf_get_smp_processor_id()];
>
>         for (i =3D 0; i < 5; i++) {
>                 /* Advance the dispatch cursor and pick the fifo. */
> @@ -442,9 +430,11 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct t=
ask_struct *prev)
>                         cpuc->dsp_cnt =3D 1 << cpuc->dsp_idx;
>                 }
>
> -               fifo =3D bpf_map_lookup_elem(&queue_arr, &cpuc->dsp_idx);
> +               u64 dsp_idx =3D cpuc->dsp_idx;
> +
> +               fifo =3D bpf_map_lookup_elem(&queue_arr, &dsp_idx);
>                 if (!fifo) {
> -                       scx_bpf_error("failed to find ring %llu", cpuc->d=
sp_idx);
> +                       scx_bpf_error("failed to find ring %llu", dsp_idx=
);
>                         return;
>                 }
>
> @@ -465,10 +455,10 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct =
task_struct *prev)
>                         }
>
>                         if (taskc->highpri)
> -                               __sync_fetch_and_sub(&nr_highpri_queued, =
1);
> +                               __sync_fetch_and_sub(&qa.nr_highpri_queue=
d, 1);
>
>                         update_core_sched_head_seq(p);
> -                       __sync_fetch_and_add(&nr_dispatched, 1);
> +                       __sync_fetch_and_add(&qa.nr_dispatched, 1);
>
>                         scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, 0);
>
> @@ -529,8 +519,8 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct ta=
sk_struct *prev)
>         }
>
>         for (i =3D 0; i < MAX_SUB_SCHEDS; i++) {
> -               if (sub_sched_cgroup_ids[i] &&
> -                   scx_bpf_sub_dispatch(sub_sched_cgroup_ids[i]))
> +               if (qa.sub_sched_cgroup_ids[i] &&
> +                   scx_bpf_sub_dispatch(qa.sub_sched_cgroup_ids[i]))
>                         return;
>         }
>
> @@ -546,21 +536,15 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct =
task_struct *prev)
>                 }
>
>                 taskc->core_sched_seq =3D
> -                       core_sched_tail_seqs[weight_to_idx(prev->scx.weig=
ht)]++;
> +                       qa.core_sched_tail_seqs[weight_to_idx(prev->scx.w=
eight)]++;
>         }
>  }
>
>  void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
>  {
> -       struct cpu_ctx *cpuc;
> -       u32 zero =3D 0;
> +       struct cpu_ctx __arena *cpuc =3D &qa.cpu_ctxs[bpf_get_smp_process=
or_id()];
>         int idx;
>
> -       if (!(cpuc =3D bpf_map_lookup_elem(&cpu_ctx_stor, &zero))) {
> -               scx_bpf_error("failed to look up cpu_ctx");
> -               return;
> -       }
> -
>         /*
>          * Use the running avg of weights to select the target cpuperf le=
vel.
>          * This is a demonstration of the cpuperf feature rather than a
> @@ -589,7 +573,7 @@ static s64 task_qdist(struct task_struct *p)
>                 return 0;
>         }
>
> -       qdist =3D taskc->core_sched_seq - core_sched_head_seqs[idx];
> +       qdist =3D taskc->core_sched_seq - qa.core_sched_head_seqs[idx];
>
>         /*
>          * As queue index increments, the priority doubles. The queue w/ =
index 3
> @@ -679,13 +663,10 @@ void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx =
*dctx)
>
>  void BPF_STRUCT_OPS(qmap_dump_cpu, struct scx_dump_ctx *dctx, s32 cpu, b=
ool idle)
>  {
> -       u32 zero =3D 0;
> -       struct cpu_ctx *cpuc;
> +       struct cpu_ctx __arena *cpuc =3D &qa.cpu_ctxs[cpu];
>
>         if (suppress_dump || idle)
>                 return;
> -       if (!(cpuc =3D bpf_map_lookup_percpu_elem(&cpu_ctx_stor, &zero, c=
pu)))
> -               return;
>
>         scx_bpf_dump("QMAP: dsp_idx=3D%llu dsp_cnt=3D%llu avg_weight=3D%u=
 cpuperf_target=3D%u",
>                      cpuc->dsp_idx, cpuc->dsp_cnt, cpuc->avg_weight,
> @@ -802,7 +783,7 @@ struct {
>   */
>  static void monitor_cpuperf(void)
>  {
> -       u32 zero =3D 0, nr_cpu_ids;
> +       u32 nr_cpu_ids;
>         u64 cap_sum =3D 0, cur_sum =3D 0, cur_min =3D SCX_CPUPERF_ONE, cu=
r_max =3D 0;
>         u64 target_sum =3D 0, target_min =3D SCX_CPUPERF_ONE, target_max =
=3D 0;
>         const struct cpumask *online;
> @@ -812,7 +793,7 @@ static void monitor_cpuperf(void)
>         online =3D scx_bpf_get_online_cpumask();
>
>         bpf_for(i, 0, nr_cpu_ids) {
> -               struct cpu_ctx *cpuc;
> +               struct cpu_ctx __arena *cpuc =3D &qa.cpu_ctxs[i];
>                 u32 cap, cur;
>
>                 if (!bpf_cpumask_test_cpu(i, online))
> @@ -834,11 +815,6 @@ static void monitor_cpuperf(void)
>                 cur_sum +=3D cur * cap / SCX_CPUPERF_ONE;
>                 cap_sum +=3D cap;
>
> -               if (!(cpuc =3D bpf_map_lookup_percpu_elem(&cpu_ctx_stor, =
&zero, i))) {
> -                       scx_bpf_error("failed to look up cpu_ctx");
> -                       goto out;
> -               }
> -
>                 /* collect target */
>                 cur =3D cpuc->cpuperf_target;
>                 target_sum +=3D cur;
> @@ -846,14 +822,14 @@ static void monitor_cpuperf(void)
>                 target_max =3D cur > target_max ? cur : target_max;
>         }
>
> -       cpuperf_min =3D cur_min;
> -       cpuperf_avg =3D cur_sum * SCX_CPUPERF_ONE / cap_sum;
> -       cpuperf_max =3D cur_max;
> +       qa.cpuperf_min =3D cur_min;
> +       qa.cpuperf_avg =3D cur_sum * SCX_CPUPERF_ONE / cap_sum;
> +       qa.cpuperf_max =3D cur_max;
> +
> +       qa.cpuperf_target_min =3D target_min;
> +       qa.cpuperf_target_avg =3D target_sum / nr_online_cpus;
> +       qa.cpuperf_target_max =3D target_max;
>
> -       cpuperf_target_min =3D target_min;
> -       cpuperf_target_avg =3D target_sum / nr_online_cpus;
> -       cpuperf_target_max =3D target_max;
> -out:
>         scx_bpf_put_cpumask(online);
>  }
>
> @@ -996,8 +972,8 @@ s32 BPF_STRUCT_OPS(qmap_sub_attach, struct scx_sub_at=
tach_args *args)
>         s32 i;
>
>         for (i =3D 0; i < MAX_SUB_SCHEDS; i++) {
> -               if (!sub_sched_cgroup_ids[i]) {
> -                       sub_sched_cgroup_ids[i] =3D args->ops->sub_cgroup=
_id;
> +               if (!qa.sub_sched_cgroup_ids[i]) {
> +                       qa.sub_sched_cgroup_ids[i] =3D args->ops->sub_cgr=
oup_id;
>                         bpf_printk("attaching sub-sched[%d] on %s",
>                                    i, args->cgroup_path);
>                         return 0;
> @@ -1012,8 +988,8 @@ void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_=
detach_args *args)
>         s32 i;
>
>         for (i =3D 0; i < MAX_SUB_SCHEDS; i++) {
> -               if (sub_sched_cgroup_ids[i] =3D=3D args->ops->sub_cgroup_=
id) {
> -                       sub_sched_cgroup_ids[i] =3D 0;
> +               if (qa.sub_sched_cgroup_ids[i] =3D=3D args->ops->sub_cgro=
up_id) {
> +                       qa.sub_sched_cgroup_ids[i] =3D 0;
>                         bpf_printk("detaching sub-sched[%d] on %s",
>                                    i, args->cgroup_path);
>                         break;
> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index e7c89a2bc3d8..8844499c14c4 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -10,9 +10,11 @@
>  #include <inttypes.h>
>  #include <signal.h>
>  #include <libgen.h>
> +#include <sys/mman.h>
>  #include <sys/stat.h>
>  #include <bpf/bpf.h>
>  #include <scx/common.h>
> +#include "scx_qmap.h"
>  #include "scx_qmap.bpf.skel.h"
>
>  const char help_fmt[] =3D
> @@ -60,6 +62,8 @@ int main(int argc, char **argv)
>  {
>         struct scx_qmap *skel;
>         struct bpf_link *link;
> +       struct qmap_arena *qa;
> +       __u32 test_error_cnt =3D 0;
>         int opt;
>
>         libbpf_set_print(libbpf_print_fn);
> @@ -76,7 +80,7 @@ int main(int argc, char **argv)
>                         skel->rodata->slice_ns =3D strtoull(optarg, NULL,=
 0) * 1000;
>                         break;
>                 case 'e':
> -                       skel->bss->test_error_cnt =3D strtoul(optarg, NUL=
L, 0);
> +                       test_error_cnt =3D strtoul(optarg, NULL, 0);
>                         break;
>                 case 't':
>                         skel->rodata->stall_user_nth =3D strtoul(optarg, =
NULL, 0);
> @@ -142,29 +146,32 @@ int main(int argc, char **argv)
>         SCX_OPS_LOAD(skel, qmap_ops, scx_qmap, uei);
>         link =3D SCX_OPS_ATTACH(skel, qmap_ops, scx_qmap);
>
> +       qa =3D &skel->arena->qa;
> +       qa->test_error_cnt =3D test_error_cnt;
> +
>         while (!exit_req && !UEI_EXITED(skel, uei)) {
> -               long nr_enqueued =3D skel->bss->nr_enqueued;
> -               long nr_dispatched =3D skel->bss->nr_dispatched;
> +               long nr_enqueued =3D qa->nr_enqueued;
> +               long nr_dispatched =3D qa->nr_dispatched;
>
> -               printf("stats  : enq=3D%lu dsp=3D%lu delta=3D%ld reenq/cp=
u0=3D%"PRIu64"/%"PRIu64" deq=3D%"PRIu64" core=3D%"PRIu64" enq_ddsp=3D%"PRIu=
64"\n",
> +               printf("stats  : enq=3D%lu dsp=3D%lu delta=3D%ld reenq/cp=
u0=3D%llu/%llu deq=3D%llu core=3D%llu enq_ddsp=3D%llu\n",
>                        nr_enqueued, nr_dispatched, nr_enqueued - nr_dispa=
tched,
> -                      skel->bss->nr_reenqueued, skel->bss->nr_reenqueued=
_cpu0,
> -                      skel->bss->nr_dequeued,
> -                      skel->bss->nr_core_sched_execed,
> -                      skel->bss->nr_ddsp_from_enq);
> -               printf("         exp_local=3D%"PRIu64" exp_remote=3D%"PRI=
u64" exp_timer=3D%"PRIu64" exp_lost=3D%"PRIu64"\n",
> -                      skel->bss->nr_expedited_local,
> -                      skel->bss->nr_expedited_remote,
> -                      skel->bss->nr_expedited_from_timer,
> -                      skel->bss->nr_expedited_lost);
> +                      qa->nr_reenqueued, qa->nr_reenqueued_cpu0,
> +                      qa->nr_dequeued,
> +                      qa->nr_core_sched_execed,
> +                      qa->nr_ddsp_from_enq);
> +               printf("         exp_local=3D%llu exp_remote=3D%llu exp_t=
imer=3D%llu exp_lost=3D%llu\n",
> +                      qa->nr_expedited_local,
> +                      qa->nr_expedited_remote,
> +                      qa->nr_expedited_from_timer,
> +                      qa->nr_expedited_lost);
>                 if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
>                         printf("cpuperf: cur min/avg/max=3D%u/%u/%u targe=
t min/avg/max=3D%u/%u/%u\n",
> -                              skel->bss->cpuperf_min,
> -                              skel->bss->cpuperf_avg,
> -                              skel->bss->cpuperf_max,
> -                              skel->bss->cpuperf_target_min,
> -                              skel->bss->cpuperf_target_avg,
> -                              skel->bss->cpuperf_target_max);
> +                              qa->cpuperf_min,
> +                              qa->cpuperf_avg,
> +                              qa->cpuperf_max,
> +                              qa->cpuperf_target_min,
> +                              qa->cpuperf_target_avg,
> +                              qa->cpuperf_target_max);
>                 fflush(stdout);
>                 sleep(1);
>         }
> diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
> new file mode 100644
> index 000000000000..52153230bfce
> --- /dev/null
> +++ b/tools/sched_ext/scx_qmap.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Shared definitions between scx_qmap.bpf.c and scx_qmap.c.
> + *
> + * The scheduler keeps all mutable state in a single BPF arena map. stru=
ct
> + * qmap_arena is the one object that lives at the base of the arena and =
is
> + * mmap'd into userspace so the loader can read counters directly.
> + *
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
> + */
> +#ifndef __SCX_QMAP_H
> +#define __SCX_QMAP_H
> +
> +#ifdef __BPF__
> +#include <scx/bpf_arena_common.bpf.h>
> +#else
> +#include <linux/types.h>
> +#include <scx/bpf_arena_common.h>
> +#endif
> +
> +#define MAX_SUB_SCHEDS         8
> +
> +/*
> + * cpu_ctxs[] is sized to a fixed cap so the layout is shared between BP=
F and
> + * userspace. Keep this in sync with NR_CPUS used by the BPF side.
> + */
> +#define SCX_QMAP_MAX_CPUS      1024
> +
> +struct cpu_ctx {
> +       __u64 dsp_idx;          /* dispatch index */
> +       __u64 dsp_cnt;          /* remaining count */
> +       __u32 avg_weight;
> +       __u32 cpuperf_target;
> +};
> +
> +struct qmap_arena {
> +       /* userspace-visible stats */
> +       __u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cp=
u0;
> +       __u64 nr_dequeued, nr_ddsp_from_enq;
> +       __u64 nr_core_sched_execed;
> +       __u64 nr_expedited_local, nr_expedited_remote;
> +       __u64 nr_expedited_lost, nr_expedited_from_timer;
> +       __u64 nr_highpri_queued;
> +       __u32 test_error_cnt;
> +       __u32 cpuperf_min, cpuperf_avg, cpuperf_max;
> +       __u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
> +
> +       /* kernel-side runtime state */
> +       __u64 sub_sched_cgroup_ids[MAX_SUB_SCHEDS];
> +       __u64 core_sched_head_seqs[5];
> +       __u64 core_sched_tail_seqs[5];
> +
> +       struct cpu_ctx cpu_ctxs[SCX_QMAP_MAX_CPUS];
> +};
> +
> +#endif /* __SCX_QMAP_H */
> --
> 2.53.0
>
>
