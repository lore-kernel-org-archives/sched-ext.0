Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7112D21B
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354327; cv=fail; b=lDvt3pZUv2rhehzNmRzjXHSQ46xy/1aV1Oxp+xv5Ib2klaE2q7pmFq9xNtAnjCcjLSy/tDHGuAiImSUZ7sTK3KB0If1lO8tr5So5ZNFEkA3DhsNi5GktL9pOXb3s/EjjyYiQT+ecLZDwqc0jhBNatVsSKvfZ/jbA0GtNwQ3DEl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354327; c=relaxed/simple;
	bh=iDZDEIAzjNPc/Gj5pZB1F0pY6kchkF5LGxRc8zh8v68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKormt8LlK9t8YmtNqvk/gyYRG14pJX+rnorO+IShDNYCqj1sZPB9fRW4QvFBguaPXT9admBnTQozne8cs3D3oTAzkecRylfSOB7ghpjm0i/E/FFhiRH3yE7ZVSSS/3FgtNJcCtqV3WZLHx5cQ7RLOuSd7IDthat+LuetAGAWJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VhMpQ5YV; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VhMpQ5YV"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FLhSpR3772462
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 08:45:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KFwWHhzIMA30BA8ATDG2Cq/vm28Po4OpXDAemHM79OM=; b=VhMpQ5YVgIA3
	zQM9wVg44NoyCQbllZLm94xafidOYqlItrfZmyXNhIU70x99XVIL5OEep1KUAzCG
	bANEGzd9qboaUVDF6rQQGErn11LkaoH0V/FkWyQX+Vr1oMlFUqk3cbbU4Sa1IbUy
	e6DYnS6xgCGAaavsA9Y2VRXHuIPRLsaJ7iqY1BoANfAWwjWlX6+fy51lO6NZ8Nsz
	Mtd/5STnDav+GR3Vp01RPzwd3noKmVnGw0pGvkDVD9d7jRVB2QeWAInlV6+Ec5eH
	GjZKIEn97HzljSwWRqEhMwerEliCdDnsVrxPTdiKd8fyzD2p4I9ONdg6XVweDO3Q
	+UV1dc2mxg==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84wb16w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 08:45:24 -0700 (PDT)
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488dcff87b7so37220155e9.2
        for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 08:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776354323; cv=none;
        d=google.com; s=arc-20240605;
        b=FS1SZLX6FpofUTjAKosjIRAEHsLONZsuuTjQIkMAy/byIG5kSyP4Ku2EhRUwCWbGyU
         xID+qxfcG3otfFdzpanvFR/lQhSYXstNRchKS4vPrS3TQnnNUEnBlRyQseLehhAXpWG7
         cmOCe8IyazYk74qNWHebglbhmD9smhQDlyL3ZjeFQSDi3GNAc0IDZwdtxzN262+U5kin
         x7rontzu9IuQ3WM6IxV+7LLa8CzDZdj8M7oDaOUbXzPAFa15tTLWXbVnWZqJsVE5/zCD
         ixryLwcaeIBUkJeRm45boh4VHEq5v8p5zo+DTkmiUdaD1uvOC6agErrxkUAzLxaqspYv
         bs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=7nuJQeDgsZEiLFwZDt9s6XUpEEdljKXyrzc4bgnNsLM=;
        fh=LMnInTsRnp88EuxBfkURwzhtfakmwoGYQ8PN/yTxLwk=;
        b=EWap+Y7NxRrAewN7yn1/OILkRwIQSPX2Hfv0DJ2komX2PKr86XBvA3dcxcsQ6L9a7H
         WW4vNj8k/kH5q0R4XWC8l8ptklk32jbef/t+mM8K90vgwDq08tBR0126xvviJ65kFFSX
         /UBIyNlP1uo96WrwyadiM2nFeOQMHmGX/3JYnx3Wy1Wqxb2e4pUA8BOqz5T3+hhwdPQI
         Ps+kxeX/oVHXBZgGceIoFfCpNKdLmwpUX6H1wPwg8YteOwzxssnvP8jtmGAnOp2qu2ym
         28fS8zP4++Mg/jrl9uw86//2Y7j4H/3ORWlT8c7CjZP6PVwrnqGRNK2/REpyAGbXtE6P
         Aafw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354323; x=1776959123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nuJQeDgsZEiLFwZDt9s6XUpEEdljKXyrzc4bgnNsLM=;
        b=iBPSZzhpWZ+19C7AO6Bkhz8qQkXwocMfPZH03HJnS0qJqNdCE0c3uWKLgdSwkvmtID
         YiXA8UkOf6GYZoclxJW2Yqr2MZsWXAsyjoLhYb3oKr9XcVDwKWW857acAHsvBkvdUpWJ
         LhE4jHqgXCsUVWWssWK34VsHhJ2pFibnJSkXqkVrClBictcKrnLMJ2GquxYe6IIOis5I
         0GSMDk0Xg7JxqWiCCtSYtIUAdSaAWsnsqCY7XAPCc5qpqWbAkioaRolmSP0qEn2PxJyu
         khqMVwk68tu79PX0VsltA7gXvK4hqH34Jc32eK1MUhsQueVi+FxyTfra6FoyM9pzViYM
         vwMA==
X-Forwarded-Encrypted: i=1; AFNElJ82nItjTeYU9vRCn6JtJrBqb9BsK0hslUGjaRursqfwMwNyzhyd2ASlB3j4DknJ46lgUMOoRMgaPJQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzuH/kdruK093UBUY3R5b4cqlda3rkLDya5kyn8s3xQy3YXZB8d
	9K3pE32F7wLnKLXOZ7jp1ULkoE6oyRvZvU5vETvGnr6ukuEYYvsVPX6ovb8+v3JsEjGKu7DE7MX
	aq1hBv1oFy0qbHiHl7ZhACFEGEtZmNMJ9sb5PzZh0paWE410XjOTs30ISyqsjoaMkv7k3W2tqTR
	XUZUIlMaOMYojbsnO5JWrC2O929DOcutXuyJ0=
X-Gm-Gg: AeBDievn2SGm343E1P2RH7YPgxxUfIrT3tXN2bQIZ3Ah9nyZzdxFm0DXMBt7gb/ubJp
	7f11ndPREvToTGxRqUXnSLO2BvoZpcsoMFocr1tRbxrwLBj3l1QVTlWiJEySLAZdfct4GYJ1KTj
	OPsONJ8DVvvcg9U6/a1i3niAIK3f+6Q1y24AVq677zociuhk0we1B423Kuug14wI/SzwJY4T77g
	1FI01WFZI2pa6u6yeIc+mut9kqAE55H7kCeAuAGEW6lLm8J7v/uPXNBv6hDj3Pb
X-Received: by 2002:a05:600c:c088:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-488d6843187mr271401515e9.18.1776354322738;
        Thu, 16 Apr 2026 08:45:22 -0700 (PDT)
X-Received: by 2002:a05:600c:c088:b0:486:f9d0:aac8 with SMTP id
 5b1f17b1804b1-488d6843187mr271400965e9.18.1776354322104; Thu, 16 Apr 2026
 08:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260416081626.1285617-1-tj@kernel.org> <20260416081626.1285617-5-tj@kernel.org>
In-Reply-To: <20260416081626.1285617-5-tj@kernel.org>
From: Emil Tsalapatis <etsal@meta.com>
Date: Thu, 16 Apr 2026 08:45:10 -0700
X-Gm-Features: AQROBzAZ4g4EhWtm9Cd4cJItR7ClMuJuNHhqDXuxO-HLLTdeeRHo6Ej1zA2avWM
Message-ID: <CAMe2y=Fc+gKyjwZv64Cnjor9N2_-cGgTwLenk+vYOarrDq+SFg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched_ext: scx_qmap: replace FIFO queue maps with
 arena-backed lists
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
        Changwoo Min <changwoo@igalia.com>,
        Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0OSBTYWx0ZWRfX8E9ZSuI1owoL
 OZAFClypu7E32jIo4Gzk5nW43wFVZ3UlH8/Qk1FX4xp7zoJ6GlFh7XzUjLnHx+B4KXqObTzxYRd
 cgnh1lYaCvHoUkycLMLUhTHwxDg/9tPRrt17Jc65LGgx1ZTiO2LhyksY+VQHaChRcZc9iWh0FgF
 Q6o0tdGKPAtsj9Y9RbLF6/N2epeweS/nShR2wEzAtG7X+ONCFKawLLnLcC71vgodQm6/bwPMonL
 1MO5q8xSf/8kmiE5jVH85JsBcMkyu1RQMJ4XwdRX4/rjRLhqgUo/7lqtauvmS9I9DEzE//GPJPu
 XovQs0/x5Z4Cn+aIaG/dt+YyIWRmgHODjknTxUUFVo+jmjqj5Zons5K5uZA1SgN/NbtAMs0/rSz
 CfeJiEZao9W/HMCCMtkzKd8e6WzkwdBPvtnfMRr0RLu4Z69rKFWtxwWCw5dDJtQ9fFDR5Y+JdFB
 jIQtHrfKBcJ3a3CFf9A==
X-Proofpoint-ORIG-GUID: r3MXAmdVcY-wU6sBEomO7hR8e6BkqNHB
X-Proofpoint-GUID: r3MXAmdVcY-wU6sBEomO7hR8e6BkqNHB
X-Authority-Analysis: v=2.4 cv=cf7iaHDM c=1 sm=1 tr=0 ts=69e10414 cx=c_pps
 a=ocXdEHcuFBd2kx0v6vcWqw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=VwQbUJbxAAAA:8 a=CWErhr8FAAAA:8 a=xHFGOk1MlkUge8tkP1AA:9 a=QEXdDO2ut3YA:10
 a=XRP02QYyWapGEjE7oHHB:22 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01

On Thu, Apr 16, 2026 at 1:20=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> >
> Arena simplifies verification and allows more natural programming.
> Convert scx_qmap to arena as preparation for further sub-sched work.
>
> Replace the five BPF_MAP_TYPE_QUEUE maps with doubly-linked lists in
> arena, threaded through task_ctx. Each queue is a struct qmap_fifo with
> head/tail pointers and its own per-queue bpf_res_spin_lock.
>
> qmap_dequeue() now properly removes tasks from the queue instead of
> leaving stale entries for dispatch to skip.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  tools/sched_ext/scx_qmap.bpf.c | 221 +++++++++++++++++++++------------
>  tools/sched_ext/scx_qmap.h     |   9 ++
>  2 files changed, 148 insertions(+), 82 deletions(-)
>
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index e071969c8f32..c26997ff7863 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -71,31 +71,24 @@ struct {
>
>  struct qmap_arena __arena qa;
>
> -struct qmap {
> -       __uint(type, BPF_MAP_TYPE_QUEUE);
> -       __uint(max_entries, 4096);
> -       __type(value, u32);
> -} queue0 SEC(".maps"),
> -  queue1 SEC(".maps"),
> -  queue2 SEC(".maps"),
> -  queue3 SEC(".maps"),
> -  queue4 SEC(".maps"),
> -  dump_store SEC(".maps");
> -
> -struct {
> -       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> -       __uint(max_entries, 5);
> -       __type(key, int);
> -       __array(values, struct qmap);
> -} queue_arr SEC(".maps") =3D {
> -       .values =3D {
> -               [0] =3D &queue0,
> -               [1] =3D &queue1,
> -               [2] =3D &queue2,
> -               [3] =3D &queue3,
> -               [4] =3D &queue4,
> -       },
> -};
> +/* Per-queue locks. Each in its own .data section as bpf_res_spin_lock r=
equires. */
> +__hidden struct bpf_res_spin_lock qa_q_lock0 SEC(".data.qa_q_lock0");
> +__hidden struct bpf_res_spin_lock qa_q_lock1 SEC(".data.qa_q_lock1");
> +__hidden struct bpf_res_spin_lock qa_q_lock2 SEC(".data.qa_q_lock2");
> +__hidden struct bpf_res_spin_lock qa_q_lock3 SEC(".data.qa_q_lock3");
> +__hidden struct bpf_res_spin_lock qa_q_lock4 SEC(".data.qa_q_lock4");
> +
> +static struct bpf_res_spin_lock *qa_q_lock(s32 qid)
> +{
> +       switch (qid) {
> +       case 0: return &qa_q_lock0;
> +       case 1: return &qa_q_lock1;
> +       case 2: return &qa_q_lock2;
> +       case 3: return &qa_q_lock3;
> +       case 4: return &qa_q_lock4;
> +       default: return NULL;
> +       }
> +}
>
>  /*
>   * If enabled, CPU performance target is set according to the queue index
> @@ -123,9 +116,17 @@ static const u32 qidx_to_cpuperf_target[] =3D {
>   * arena. While the task is alive the entry is referenced from task_ctx_=
stor;
>   * while it's free the entry sits on the free list singly-linked through
>   * @next_free.
> + *
> + * When the task is queued on one of the five priority FIFOs, @q_idx is =
the
> + * queue index and @q_next/@q_prev link it in the queue's doubly-linked =
list.
> + * @q_idx is -1 when the task isn't on any queue.
>   */
>  struct task_ctx {
>         struct task_ctx __arena *next_free;     /* only valid on free lis=
t */
> +       struct task_ctx __arena *q_next;        /* queue link, NULL if ta=
il */
> +       struct task_ctx __arena *q_prev;        /* queue link, NULL if he=
ad */
> +       struct qmap_fifo __arena *fifo;         /* queue we're on, NULL i=
f not queued */
> +       s32                     pid;
>         bool                    force_local;    /* Dispatch directly to l=
ocal_dsq */
>         bool                    highpri;
>         u64                     core_sched_seq;
> @@ -196,6 +197,81 @@ static struct task_ctx __arena *lookup_task_ctx(stru=
ct task_struct *p)
>         return v->taskc;
>  }
>
> +/* Append @taskc to the tail of @fifo. Must not already be queued. */
> +static void qmap_fifo_enqueue(struct qmap_fifo __arena *fifo,
> +                             struct task_ctx __arena *taskc)
> +{
> +       struct bpf_res_spin_lock *lock =3D qa_q_lock(fifo->idx);
> +
> +       if (!lock || qmap_spin_lock(lock))
> +               return;
> +       taskc->fifo =3D fifo;
> +       taskc->q_next =3D NULL;
> +       taskc->q_prev =3D fifo->tail;
> +       if (fifo->tail)
> +               fifo->tail->q_next =3D taskc;
> +       else
> +               fifo->head =3D taskc;
> +       fifo->tail =3D taskc;
> +       bpf_res_spin_unlock(lock);
> +}
> +
> +/* Pop the head of @fifo. Returns NULL if empty. */
> +static struct task_ctx __arena *qmap_fifo_pop(struct qmap_fifo __arena *=
fifo)
> +{
> +       struct bpf_res_spin_lock *lock =3D qa_q_lock(fifo->idx);
> +       struct task_ctx __arena *taskc;
> +
> +       if (!lock || qmap_spin_lock(lock))
> +               return NULL;
> +       taskc =3D fifo->head;
> +       if (taskc) {
> +               fifo->head =3D taskc->q_next;
> +               if (taskc->q_next)
> +                       taskc->q_next->q_prev =3D NULL;
> +               else
> +                       fifo->tail =3D NULL;
> +               taskc->q_next =3D NULL;
> +               taskc->q_prev =3D NULL;
> +               taskc->fifo =3D NULL;
> +       }
> +       bpf_res_spin_unlock(lock);
> +       return taskc;
> +}
> +
> +/* Remove @taskc from its fifo. No-op if not queued. */
> +static void qmap_fifo_remove(struct task_ctx __arena *taskc)
> +{
> +       struct qmap_fifo __arena *fifo =3D taskc->fifo;
> +       struct bpf_res_spin_lock *lock;
> +
> +       if (!fifo)
> +               return;
> +
> +       lock =3D qa_q_lock(fifo->idx);
> +       if (!lock || qmap_spin_lock(lock))
> +               return;
> +
> +       /* Re-check under lock =E2=80=94 a concurrent pop may have cleare=
d fifo. */
> +       if (taskc->fifo !=3D fifo) {
> +               bpf_res_spin_unlock(lock);
> +               return;
> +       }
> +
> +       if (taskc->q_next)
> +               taskc->q_next->q_prev =3D taskc->q_prev;
> +       else
> +               fifo->tail =3D taskc->q_prev;
> +       if (taskc->q_prev)
> +               taskc->q_prev->q_next =3D taskc->q_next;
> +       else
> +               fifo->head =3D taskc->q_next;
> +       taskc->q_next =3D NULL;
> +       taskc->q_prev =3D NULL;
> +       taskc->fifo =3D NULL;
> +       bpf_res_spin_unlock(lock);
> +}
> +
>  s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
>                    s32 prev_cpu, u64 wake_flags)
>  {
> @@ -237,9 +313,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>  {
>         static u32 user_cnt, kernel_cnt;
>         struct task_ctx __arena *taskc;
> -       u32 pid =3D p->pid;
>         int idx =3D weight_to_idx(p->scx.weight);
> -       void *ring;
>         s32 cpu;
>
>         if (enq_flags & SCX_ENQ_REENQ) {
> @@ -325,17 +399,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct=
 *p, u64 enq_flags)
>                 return;
>         }
>
> -       ring =3D bpf_map_lookup_elem(&queue_arr, &idx);
> -       if (!ring) {
> -               scx_bpf_error("failed to find ring %d", idx);
> -               return;
> -       }
> -
> -       /* Queue on the selected FIFO. If the FIFO overflows, punt to glo=
bal. */
> -       if (bpf_map_push_elem(ring, &pid, 0)) {
> -               scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, enq_flags);
> -               return;
> -       }
> +       /* Queue on the selected FIFO. */
> +       qmap_fifo_enqueue(&qa.fifos[idx], taskc);
>
>         if (highpri_boosting && p->scx.weight >=3D HIGHPRI_WEIGHT) {
>                 taskc->highpri =3D true;
> @@ -344,15 +409,20 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struc=
t *p, u64 enq_flags)
>         __sync_fetch_and_add(&qa.nr_enqueued, 1);
>  }
>
> -/*
> - * The BPF queue map doesn't support removal and sched_ext can handle sp=
urious
> - * dispatches. qmap_dequeue() is only used to collect statistics.
> - */
>  void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags)
>  {
> +       struct task_ctx __arena *taskc;
> +
>         __sync_fetch_and_add(&qa.nr_dequeued, 1);
>         if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC)
>                 __sync_fetch_and_add(&qa.nr_core_sched_execed, 1);
> +
> +       taskc =3D lookup_task_ctx(p);
> +       if (taskc && taskc->fifo) {
> +               if (taskc->highpri)
> +                       __sync_fetch_and_sub(&qa.nr_highpri_queued, 1);
> +               qmap_fifo_remove(taskc);
> +       }
>  }
>
>  static void update_core_sched_head_seq(struct task_struct *p)
> @@ -435,8 +505,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct ta=
sk_struct *prev)
>         struct cpu_ctx __arena *cpuc;
>         struct task_ctx __arena *taskc;
>         u32 batch =3D dsp_batch ?: 1;
> -       void *fifo;
> -       s32 i, pid;
> +       s32 i;
>
>         if (dispatch_highpri(false))
>                 return;
> @@ -467,30 +536,18 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct =
task_struct *prev)
>                         cpuc->dsp_cnt =3D 1 << cpuc->dsp_idx;
>                 }
>
> -               u64 dsp_idx =3D cpuc->dsp_idx;
> -
> -               fifo =3D bpf_map_lookup_elem(&queue_arr, &dsp_idx);
> -               if (!fifo) {
> -                       scx_bpf_error("failed to find ring %llu", dsp_idx=
);
> -                       return;
> -               }
> -
>                 /* Dispatch or advance. */
>                 bpf_repeat(BPF_MAX_LOOPS) {
>                         struct task_ctx __arena *taskc;
>
> -                       if (bpf_map_pop_elem(fifo, &pid))
> +                       taskc =3D qmap_fifo_pop(&qa.fifos[cpuc->dsp_idx]);
> +                       if (!taskc)
>                                 break;
>
> -                       p =3D bpf_task_from_pid(pid);
> +                       p =3D bpf_task_from_pid(taskc->pid);
>                         if (!p)
>                                 continue;
>
> -                       if (!(taskc =3D lookup_task_ctx(p))) {
> -                               bpf_task_release(p);
> -                               return;
> -                       }
> -
>                         if (taskc->highpri)
>                                 __sync_fetch_and_sub(&qa.nr_highpri_queue=
d, 1);
>
> @@ -661,6 +718,10 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct =
task_struct *p,
>         }
>
>         taskc->next_free =3D NULL;
> +       taskc->q_next =3D NULL;
> +       taskc->q_prev =3D NULL;
> +       taskc->fifo =3D NULL;
> +       taskc->pid =3D p->pid;
>         taskc->force_local =3D false;
>         taskc->highpri =3D false;
>         taskc->core_sched_seq =3D 0;
> @@ -701,38 +762,29 @@ void BPF_STRUCT_OPS(qmap_exit_task, struct task_str=
uct *p,
>
>  void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
>  {
> -       s32 i, pid;
> +       struct task_ctx __arena *taskc;
> +       s32 i;
> +
> +       QMAP_TOUCH_ARENA();
>
>         if (suppress_dump)
>                 return;
>
> +       /*
> +        * Walk the queue lists without locking - kfunc calls (scx_bpf_du=
mp)
> +        * aren't in the verifier's kfunc_spin_allowed() list so we can't=
 hold
> +        * a lock and dump. Best-effort; racing may print stale pids but =
the
> +        * walk is bounded by bpf_repeat() so it always terminates.
> +        */
>         bpf_for(i, 0, 5) {
> -               void *fifo;
> -
> -               if (!(fifo =3D bpf_map_lookup_elem(&queue_arr, &i)))
> -                       return;
> -
>                 scx_bpf_dump("QMAP FIFO[%d]:", i);
> -
> -               /*
> -                * Dump can be invoked anytime and there is no way to ite=
rate in
> -                * a non-destructive way. Pop and store in dump_store and=
 then
> -                * restore afterwards. If racing against new enqueues, or=
dering
> -                * can get mixed up.
> -                */
> -               bpf_repeat(4096) {
> -                       if (bpf_map_pop_elem(fifo, &pid))
> -                               break;
> -                       bpf_map_push_elem(&dump_store, &pid, 0);
> -                       scx_bpf_dump(" %d", pid);
> -               }
> -
> +               taskc =3D qa.fifos[i].head;
>                 bpf_repeat(4096) {
> -                       if (bpf_map_pop_elem(&dump_store, &pid))
> +                       if (!taskc)
>                                 break;
> -                       bpf_map_push_elem(fifo, &pid, 0);
> +                       scx_bpf_dump(" %d", taskc->pid);
> +                       taskc =3D taskc->q_next;
>                 }
> -
>                 scx_bpf_dump("\n");
>         }
>  }
> @@ -756,6 +808,8 @@ void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_c=
tx *dctx, struct task_struc
>
>         QMAP_TOUCH_ARENA();
>
> +       QMAP_TOUCH_ARENA();
> +
>         if (suppress_dump)
>                 return;
>         v =3D bpf_task_storage_get(&task_ctx_stor, p, NULL, 0);
> @@ -1018,6 +1072,9 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
>         }
>         qa.task_ctxs =3D slab;
>
> +       bpf_for(i, 0, 5)
> +               qa.fifos[i].idx =3D i;
> +
>         bpf_for(i, 0, max_tasks)
>                 slab[i].next_free =3D (i + 1 < max_tasks) ? &slab[i + 1] =
: NULL;
>         qa.task_free_head =3D &slab[0];
> diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
> index c183d82632b3..9c0da5a301cb 100644
> --- a/tools/sched_ext/scx_qmap.h
> +++ b/tools/sched_ext/scx_qmap.h
> @@ -37,6 +37,12 @@ struct cpu_ctx {
>  /* Opaque to userspace; defined in scx_qmap.bpf.c. */
>  struct task_ctx;
>
> +struct qmap_fifo {
> +       struct task_ctx __arena *head;
> +       struct task_ctx __arena *tail;
> +       __s32 idx;
> +};
> +
>  struct qmap_arena {
>         /* userspace-visible stats */
>         __u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cp=
u0;
> @@ -59,6 +65,9 @@ struct qmap_arena {
>         /* task_ctx slab; allocated and threaded by qmap_init() */
>         struct task_ctx __arena *task_ctxs;
>         struct task_ctx __arena *task_free_head;
> +
> +       /* five priority FIFOs, each a doubly-linked list through task_ct=
x */
> +       struct qmap_fifo fifos[5];
>  };
>
>  #endif /* __SCX_QMAP_H */
> --
> 2.53.0
>
>
