Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CC2475E3
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341744; cv=pass; b=fr8Bwc5uI/91s++wWYNjDQ0v8kUaiY1auUTrT2qSxzq5sKBs2vE60VeFV63pB5mhdoiQFwehncDwEUIS4RfoDXgWuYOvUEkTnrGrAL+1pYumPRr92gYC3GXZ8jc9OPQiuJ7KFjhn3J+EWhX5zK1nZoExIm+oaQbQnTBRbysOexI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341744; c=relaxed/simple;
	bh=RprgxPFmnpgbC8E8vm25GIOO+muVY0btkoel/uvAQ0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJZY0IN25bmi2CqbF/reY+fomW0DQnzLsME9o8zzgNHYB2WJKOj8CcU3YJueJ7nbeRpz13k3WQv0VNmv19G2okLL/rQSKOOM6DlTZM1l8Llr6dQ3Iqbqru8p/R8Z4FyDIVs/mxonSQSrsuuwySvmKC4qIXZbr/EbA7bRcD0vo00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4LGMUMc; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4LGMUMc"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e08baf860so6025297a91.2
        for <sched-ext@lists.linux.dev>; Fri, 17 Jul 2026 19:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784341742; cv=none;
        d=google.com; s=arc-20260327;
        b=AN6vF3VA/apOqWYhcHCAp/VyTWGTi/a4BJuu/v/TsDEDsIonBBEKVvrDBdivuoIao+
         X9iTdwZV4rjwKZMuAPovzopjMe6cDs0BX2pKLSW8GCeANMw+oH8mYKkaMEezfIsNEjUH
         EpZLAv74jBxqtnCBnp9/Es8h1BOVN1Ac9jC3snyXSeymtSDRpA+2PQo60ot75UY6VQQw
         PhpPx//63tk9+s+NgOj8CEzg7qeJSKYqpmpIW6mtUb7qrZmeiggU69ugs0NMX+NvSex7
         f/Ranq5qwnH/wlyhFPdKdE0rurNCTIMWxB6q1ZqV6DDis9BBt9p91dpqmrmWdmUsDace
         imJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qxltxR+k8xkus8Vl5jwvM71LH1G0B1QukqFpM+EHkXM=;
        fh=dqPFAJopn10j4DBvLu0NpNNFMlOZfEDaLPl0OybC3qY=;
        b=nsWV0eew3ck9XmVePuuavnhQ28cFTKxynIceQXkn6E4ih9O38D5Z+aNKe+jBLYDcdZ
         3A5/Orm/DZPZKutDLJ2mVZWMeihcI3T+GbqcvhJZmHxy2fwrTTpsoIbFULe1sYnkR2Op
         vnWU/tXHVUTA9wvj3mWXgZL9jyij38OsLyR2W2RM/F1gyuoEzgPfid/i5hQ31wmRbUdh
         t2hVtCjrvv+JN2JGcSifL/mX4NuTKHAxgI6std8KDyNnQLn+SgfU9uRfQkJ1dgB5eal3
         mi/laDB6g8wulblF5uYtgtFcPaEyfyiVqGDNY3VHZVLYbZbs4ktOUzhMdAw2oV9UKCiS
         wzTQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784341742; x=1784946542; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qxltxR+k8xkus8Vl5jwvM71LH1G0B1QukqFpM+EHkXM=;
        b=g4LGMUMcXd218eU8P3bB8jMhuLsNUbzLRqwFcEwCM0KVgV/QKplaOlS8ox+8uqu9YF
         WcC1zfXXeW6l8Cj0WI0uuU+YhQiFWBo1l3WT+GZLsNFuMgdb9yqpyLk/pWbWLIdTlNlN
         humNXbAoGYwuxI0kW8N+T7RyBobpD9ygrmQ9L90IoHP/22qVIaICedYVU1atNp8LTDbG
         NQYIfKClAeDJVD2ewcJEc9vIUEjyZP+AigRbjpLMZwl5FuWBJB+inXDQ0GZlS/CPRs/m
         QnjNJppgOV7T77dh19Qp8gfM2sQPHrR5Lge2yXqSQBlqVYyKfUFZXVp9n4RF/C2OdP2u
         UTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784341742; x=1784946542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qxltxR+k8xkus8Vl5jwvM71LH1G0B1QukqFpM+EHkXM=;
        b=AZihI9Y+J5e6ER9qH+H0UX+deOkt5Zjl1elYDOJFQ/Ws7wk7R6r2YAKrH/TVtGSnNA
         homGaD4j3sl1uyZTsHwuMGZ4EY/Ywcxc/OgYQb7ccgzNrudFamjPK+d77DTPMthJZsqO
         98flmDZWJ7kc2DPJLH/7qi+v4IfUvSaniaBLz4g75Va6f7Ei1UUwzmIE1y1ScMwMwRnr
         n93I6f/RLGIUi9cGWMchKgdk5m7HQHn4Xxu3T9ZWfaiMf7qLCk4iffk3IlAXpyIyaz+a
         zNxcP11LMRwfbC2kSeabi0GHGs7NvZXSDgs1Te3VH2cT+wbI2AzbXV4sqdBPx5iYKa3Y
         thOw==
X-Forwarded-Encrypted: i=1; AHgh+Rpznz4W/bbrzaU4BXJ6ZFNq1ip3u9BJcaPopz04wYjZh4qEwvdSUALWKb2iEqr/uCvWDwJmnzJOiUc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwJHWnhrirZiCxO1T88XUfoWsEVRL8NKobwxhjQ8qmTcwBDtLwJ
	T8fUPPBHTRpeWqRaFUr+/KZyldXSOsaPLriCNOn9F/St7iqPAA7+qEv8/cG4MgEdleFPcp2+q87
	Yvq6By5LPqk19Auc6MTp+JzCjo1Z0kyufiwD7mzc=
X-Gm-Gg: AfdE7cnKkF9J2bJ/Ut6T1HfpbrwDgU/yH5PbRZlPzOOLe00x643TAiRi7x7p/es56hs
	pRDSAgIbV2uUxZrhRC+p6EXgH57aoXu+/a+Sr3JNF80LuAM8JREAdmbarLX133jSLPorJ0HZZiX
	cuOMI/oQGygQbS4lGncaVrfDz6HzP5MW2fQewc0zx69umcvuQcAaVUAS0sfqnhWbJhKTs14G8IK
	ek9sCFbc3qOMPMthW9lMQRFlI9mQsZkcXHRJEkp25C+yomfEFq+2GIBi1XSL2z8+MjH65aE3KRm
	dsPwldiZecXSPB2EhNk4l26EL2/sFDnJIPzlwfJ0p6VrZSyfoELCrSWcBi6iYX0kQtFeag9V2iA
	HO8V38qyFP7x0nnNnoP7DFhCX
X-Received: by 2002:a17:90b:5604:b0:37f:9ce2:348f with SMTP id
 98e67ed59e1d1-38e4b55ab8dmr5479732a91.32.1784341741540; Fri, 17 Jul 2026
 19:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716132229.61603-1-arighi@nvidia.com> <20260716132229.61603-11-arighi@nvidia.com>
In-Reply-To: <20260716132229.61603-11-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 17 Jul 2026 19:28:49 -0700
X-Gm-Features: AUfX_myfNA4CpbxHxErp3EPXjIIuxH1-zr2d7nTnsyDvWBhh9TLOVyhT2ojp6QE
Message-ID: <CANDhNCoaZnQXeFcxAv4XA4dW9sq9k+nm+0=EcqmLDvhMqKPdnw@mail.gmail.com>
Subject: Re: [PATCH 10/11] sched_ext: scx_qmap: Add proxy execution support
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 6:23=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> Add a -B option to opt scx_qmap into queueing mutex-blocked tasks for
> proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
> and mutex waiters block normally. With -B, blocked donors are passed to
> qmap_enqueue() with SCX_ENQ_BLOCKED.
>
> When scx_qmap receives a blocked donor, dispatch it directly to the
> local DSQ of its current cid with a fresh slice and SCX_ENQ_PREEMPT.
> This places the donor at the head of the DSQ and requests an immediate
> reschedule, allowing the core proxy-exec path to run the mutex owner
> using the donor's scheduling context as soon as the donor is selected.

Hey Andrea!

Thanks again for your great work on all this, I'm working to test your
changes with my full proxy-exec tree, but before that I caught one
issue here.

I was excited to try this out, but when building and running this from
your kernel tree in a VM, (who's kernel is running from the same
kernel tree, built on the host), I get the following error (with or
without -B). The other scx_ schedulers in tools/sched_ext/ seem to
load and run ok.  Maybe is there something I'm forgetting to do here?

thanks
-john

# ./build/bin/scx_qmap -B
libbpf: prog 'qmap_dequeue': BPF program load failed: -EACCES
libbpf: prog 'qmap_dequeue': -- BEGIN PROG LOAD LOG --
0: R1=3Dctx() R10=3Dfp0
; void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64
deq_flags) @ scx_qmap.bpf.c:584
0: (79) r2 =3D *(u64 *)(r1 +0)
func 'dequeue' arg0 has btf_id 142670 type STRUCT 'task_struct'
1: R1=3Dctx() R2=3Dtrusted_ptr_task_struct()
1: (79) r4 =3D *(u64 *)(r1 +8)          ; R1=3Dctx() R4=3Dscalar()
; __sync_fetch_and_add(&qa.nr_dequeued, 1); @ scx_qmap.bpf.c:588
2: (18) r1 =3D 0x10000fff7000           ; R1=3Dscalar()
4: (18) r3 =3D 0x10000fff7000           ; R3=3Dscalar()
6: (07) r3 +=3D 32                      ; R3=3Dscalar()
7: (bf) r5 =3D addr_space_cast(r3, 0, 1)        ; R3=3Dscalar() R5=3Darena
8: (b7) r3 =3D 1                        ; R3=3D1
9: (b7) r0 =3D 1                        ; R0=3D1
10: (db) lock *(u64 *)(r5 +0) +=3D r0   ; R0=3D1 R5=3Darena
11: (18) r5 =3D 0x100000000             ; R5=3D0x100000000
; if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC) @ scx_qmap.bpf.c:589
13: (5f) r4 &=3D r5                     ;
R4=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3D0x100000000,smax32=3Dumax32=3D0=
,var_off=3D(0x0;
0x100000000))
14: (15) if r4 =3D=3D 0x0 goto pc+3       ; R4=3D0x100000000
; __sync_fetch_and_add(&qa.nr_core_sched_execed, 1); @ scx_qmap.bpf.c:590
15: (07) r1 +=3D 48                     ; R1=3Dscalar()
16: (bf) r1 =3D addr_space_cast(r1, 0, 1)       ; R1=3Darena
17: (db) lock *(u64 *)(r1 +0) +=3D r3   ;
; QMAP_TOUCH_ARENA(); @ scx_qmap.bpf.c:268
18: (18) r1 =3D 0xffff888104842c00      ; R1=3Dmap_ptr(map=3Darena,ks=3D0,v=
s=3D0)
; v =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0); @ scx_qmap.bpf.c:270
20: (18) r1 =3D 0xffff88810c333600      ; R1=3Dmap_ptr(map=3Dtask_ctx_stor,=
ks=3D4,vs=3D8)
22: (b7) r3 =3D 0                       ; R3=3D0
23: (b7) r4 =3D 0                       ; R4=3D0
24: (85) call bpf_task_storage_get#156        ;
R0=3Dmap_value_or_null(id=3D1,map=3Dtask_ctx_stor,ks=3D4,vs=3D8)
; if (!v || !v->taskc) @ scx_qmap.bpf.c:271
25: (15) if r0 =3D=3D 0x0 goto pc+76      ;
R0=3Dmap_value(id=3D1,map=3Dtask_ctx_stor,ks=3D4,vs=3D8)
26: (79) r7 =3D *(u64 *)(r0 +0)         ;
R0=3Dmap_value(id=3D1,map=3Dtask_ctx_stor,ks=3D4,vs=3D8) R7=3Dscalar()
27: (15) if r7 =3D=3D 0x0 goto pc+74      ; R7=3Dscalar(umin=3D1)
28: (bf) r9 =3D addr_space_cast(r7, 0, 1)       ; R7=3Dscalar(umin=3D1) R9=
=3Darena
; if (taskc && taskc->fifo) { @ scx_qmap.bpf.c:593
29: (79) r8 =3D *(u64 *)(r9 +24)        ; R8=3Dscalar() R9=3Darena
30: (15) if r8 =3D=3D 0x0 goto pc+71      ; R8=3Dscalar(umin=3D1)
; if (taskc->highpri) @ scx_qmap.bpf.c:594
31: (71) r1 =3D *(u8 *)(r9 +45)         ;
R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=
=3D(0x0;
0xff)) R9=3Darena
32: (56) if w1 !=3D 0x1 goto pc+9       ; R1=3D1
33: (b7) r1 =3D 1                       ; R1=3D1
; __sync_fetch_and_sub(&qa.nr_highpri_queued, 1); @ scx_qmap.bpf.c:595
34: (87) r1 =3D -r1                     ; R1=3D-1
35: (18) r2 =3D 0x10000fff7000          ; R2=3Dscalar()
37: (07) r2 +=3D 88                     ; R2=3Dscalar()
38: (bf) r2 =3D addr_space_cast(r2, 0, 1)       ; R2=3Darena
39: (db) lock *(u64 *)(r2 +0) +=3D r1   ; R1=3D-1 R2=3Darena
; struct qmap_fifo __arena *fifo =3D taskc->fifo; @ scx_qmap.bpf.c:320
40: (79) r8 =3D *(u64 *)(r9 +24)        ; R8=3Dscalar() R9=3Darena
; if (!fifo) @ scx_qmap.bpf.c:323
41: (15) if r8 =3D=3D 0x0 goto pc+60      ; R8=3Dscalar(umin=3D1)
; lock =3D qa_q_lock(fifo->idx); @ scx_qmap.bpf.c:326
42: (bf) r2 =3D addr_space_cast(r8, 0, 1)       ; R2=3Darena R8=3Dscalar(um=
in=3D1)
43: (61) r1 =3D *(u32 *)(r2 +16)        ;
R1=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
R2=3Darena
; switch (qid) { @ scx_qmap.bpf.c:129
44: (66) if w1 s> 0x1 goto pc+8       ;
R1=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smax32=3D1,var_off=3D(0x0;
0xffffffff))
45: (18) r6 =3D 0xffff88810c3339f8      ;
R6=3Dmap_value(map=3D.data.qa_q_lock,ks=3D4,vs=3D4)
47: (16) if w1 =3D=3D 0x0 goto pc+17      ;
R1=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smax32=3D1,var_off=3D(0x0;
0xffffffff))
48: (16) if w1 =3D=3D 0x1 goto pc+1 50: R2=3Darena R7=3Dscalar(umin=3D1)
R8=3Dscalar(umin=3D1) R9=3Darena R10=3Dfp0
; switch (qid) { @ scx_qmap.bpf.c:129
50: (18) r6 =3D 0xffff88810c333bf8      ;
R6=3Dmap_value(map=3D.data.qa_q_lock,ks=3D4,vs=3D4)
52: (05) goto pc+12
65: (7b) *(u64 *)(r10 -16) =3D r2       ; R2=3Darena R10=3Dfp0 fp-16=3Daren=
a
; if (bpf_res_spin_lock(lock)) { @ scx_qmap.bpf.c:212
66: (bf) r1 =3D r6                      ;
R1=3Dmap_value(map=3D.data.qa_q_lock,ks=3D4,vs=3D4)
R6=3Dmap_value(map=3D.data.qa_q_lock,ks=3D4,vs=3D4)
67: (85) call bpf_res_spin_lock#85478         ; R0=3D0
68: (16) if w0 =3D=3D 0x0 goto pc+9       ; R0=3D0
; if (taskc->fifo !=3D fifo) { @ scx_qmap.bpf.c:331
78: (79) r1 =3D *(u64 *)(r9 +24)        ; R1=3Dscalar() R9=3Darena
79: (1d) if r1 =3D=3D r8 goto pc+1 81:
R6=3Dmap_value(map=3D.data.qa_q_lock,ks=3D4,vs=3D4) R7=3Dscalar(umin=3D1)
R8=3Dscalar(umin=3D1) R9=3Darena R10=3Dfp0 fp-16=3Darena
; bpf_res_spin_unlock(lock); @ scx_qmap.bpf.c:332
81: (79) r2 =3D *(u64 *)(r9 +16)        ; R2=3Dscalar() R9=3Darena
; if (taskc->q_next) @ scx_qmap.bpf.c:336
82: (79) r1 =3D *(u64 *)(r9 +8)         ; R1=3Dscalar() R9=3Darena
83: (15) if r1 =3D=3D 0x0 goto pc+4       ; R1=3Dscalar(umin=3D1)
84: (bf) r3 =3D addr_space_cast(r1, 0, 1)       ; R1=3Dscalar(umin=3D1) R3=
=3Darena
; taskc->q_next->q_prev =3D taskc->q_prev; @ scx_qmap.bpf.c:337
85: (7b) *(u64 *)(r3 +16) =3D r2        ; R2=3Dscalar() R3=3Darena
; if (taskc->q_prev) @ scx_qmap.bpf.c:340
86: (79) r2 =3D *(u64 *)(r9 +16)        ; R2=3Dscalar() R9=3Darena
; taskc->q_next->q_prev =3D taskc->q_prev; @ scx_qmap.bpf.c:337
87: (05) goto pc+2
; fifo->tail =3D taskc->q_prev; @ scx_qmap.bpf.c:339
90: (07) r7 +=3D 8                      ; R7=3Dscalar()
; if (taskc->q_prev) @ scx_qmap.bpf.c:340
91: (15) if r2 =3D=3D 0x0 goto pc+2       ; R2=3Dscalar(umin=3D1)
92: (07) r2 +=3D 8                      ; R2=3Dscalar()
93: (bf) r8 =3D r2                      ; R8=3Dscalar(id=3D2)
94: (bf) r2 =3D addr_space_cast(r8, 0, 1)       ; R2=3Darena R8=3Dscalar(id=
=3D2)
95: (7b) *(u64 *)(r2 +0) =3D r1         ; R1=3Dscalar(umin=3D1) R2=3Darena
96: (b7) r1 =3D 0                       ; R1=3D0
; taskc->q_prev =3D NULL; @ scx_qmap.bpf.c:345
97: (7b) *(u64 *)(r7 +16) =3D r1
R7 invalid mem access 'scalar'
processed 71 insns (limit 1000000) max_states_per_insn 1 total_states
5 peak_states 5 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'qmap_dequeue': failed to load: -EACCES
libbpf: failed to load object 'scx_qmap'
libbpf: failed to load BPF skeleton 'scx_qmap': -EACCES
[SCX_BUG] scx_qmap.c:497 (Permission denied)
Failed to load skel
