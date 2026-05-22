Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B0747CC7C
	for <sched-ext@lists.linux.dev>; Fri, 22 May 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470059; cv=none; b=YFz8oDt9d7uQS976ls+Nu8+Qz/z72hGXbCKE6tLHN0vVWLBqPx3gsob0rB2lrqCJqAQ9CePHN3teftkRNxOF5eYP7TNR46K4SunZcRN+EsYgy7RQ1Lxw2Mn9VxRBlppVJXIa6Rr4vT+OIgIiFeILxL8gMgysFO1nzCQVaPPBJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470059; c=relaxed/simple;
	bh=+r63e1oc3WloPTh53XIkH+WaiWc/hQmoeIUb51bP8GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Avtk2wuLK0huS3joDwbsvYdK2tync8R5GDQWtmahz+HkwOn/5Y8nCCFEUkKg+s7n4nG3WFE8dames2oaYxEov0Ln0O0PHw1Rfaj+pK9WEXDKYrkVyIpiOdv2/9M0Yd+1IUm+M01r3Z1xcb92q5MeYU9n6Yn75rAoT5bmfqFoTP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKQpExg5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKQpExg5"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c801d732058so3440038a12.1
        for <sched-ext@lists.linux.dev>; Fri, 22 May 2026 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779470056; x=1780074856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2t8J8aWGiCYxn0++aYVCL2MlO6XDY43+uMIzSpxSwE=;
        b=UKQpExg5Tc/Hzpv9Pg00+bFzu8FQLXFVfnnH3/pHDJpn3un1yCdjc2bXsGWzxXkQVD
         SPdNkPu1sGS75lE/6/JJCxvHTag+97T3rXC5LHu8V1OQd7npYw2Qt1jdnxxC1jmiFpqo
         cP8PivNkZ4Qe5ydT6FItsTwxPxjhdFwHHYNDK34/hXJo7HNwE8xFmAhq3cegNBdRDL0a
         kfILMJiQvaxtt1CUg0rkFdfpJDIDqwhWgCtebMHXcy5mjcMk0dmwUUBsQ9PxjtIw0TMO
         yrIeodoKoGU6L9+xPtSBq0e9vYq2+2mg09PAHeZafGUiquXE3EUP94k5XPaniYWvgz8A
         PplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470056; x=1780074856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2t8J8aWGiCYxn0++aYVCL2MlO6XDY43+uMIzSpxSwE=;
        b=DAoTIIApIHOMqcrBRDoHWNqcfSClihq0poiyP61qdR5W2ddr2aAY4bmv4yTvrY3xtX
         Ul3OuDAdOVz9g+CCWBlgd0XoETMkuKImpUmkVGiDIgqmZ2w392Hsia6wS2LWdyEWbZOl
         i8X1MXCo8KvyaQ6Ca5z4HMIUaYWoUa9ITcXNbL9pHDenJkMdm8ziBVQ+j76CxTt6HdP6
         M9wHHoAWoZYYNFo0p48GsNl9gOouQ/KH058ZllBVVGoMD7kFg5nUTR1BrSMOZp9lThsS
         pUiN/a3GH2BTu5IYKtJh64lPMekWGVXkHSAwPetI925zkahCCx96Efcosp0XiZiGy5Ko
         lm9w==
X-Gm-Message-State: AOJu0YyXqGqLtgkVmVhmobs0Xc713z3jYJA9zEoQrNqeHpPD7pxTmaSH
	j8HGHC7cediApSXEarnyJQ3XFX0MsJXlH5dsMvife56vhW+Sj08qvbOF2rzHlw==
X-Gm-Gg: Acq92OHzjJPVlzw/RAVRYvwCn6OjVDBCMjCQqFxZSRbOHiOab4/ZXeoGRrfz3xW0+VO
	oPgoi5CuREkYRhXXE/yesE+F5mRMoohysS8awtM7YiDOa4Z+LI6Qu3n9q00DB93yWONb9o8Wr3p
	e4BrxZZ6Z7UsKdPdaIdGmgUsWDtDhe4xCOLTrxOZmvctqIVcci3BAzwuQteuGGrvday3VQ2MsyP
	pg05/ul8VS/v3J4KIQ/B89lF5Wfzdl4/+FTkEEvracDSF+ZS0a8lsiggfIlgMfvZvvt9MdvAix5
	u3xOvO9+32u/5bX4CPDAzXNR8jWYYkYZq2eOgednjwaE5qJUtaD1aqb/n39RBWT80VNBbUsybV3
	deKbx//fGEUr7LiQxj0uFn0R6XKz5wRz0u7JezbbRvdQuBj22ptZnc+1U5bJ0uPmILM/yJMnNvN
	YXEQdBFoXZrpIVWm2k3udnJwY0cVWI9GdkXwLYgiNEGXubbxXP2g==
X-Received: by 2002:a05:6a20:7f90:b0:3b2:8677:8057 with SMTP id adf61e73a8af0-3b3294c87c2mr3710493637.1.1779470056414;
        Fri, 22 May 2026 10:14:16 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d6b:1176:68e:1fdb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164afe338sm2517549b3a.18.2026.05.22.10.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 10:14:15 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.2 0/2] tools/sched_ext: fix scx_qmap BPF verifier rejection
Date: Sat, 23 May 2026 01:13:17 +0800
Message-ID: <20260522171406.2171819-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_qmap fails to load with modern LLVM due to LLVM liveness killing the
PTR_TO_ARENA register alias before arena stores. The BPF verifier rejects
these stores with "RN invalid mem access 'scalar'".

Patch 1: moves bpf_addr_space_cast() before the #if block so it is always
available regardless of LLVM version.

Patch 2: calls bpf_addr_space_cast() at every arena store site in scx_qmap
where the PTR_TO_ARENA alias dies before the write.

Failure observed on sched_ext/for-next with vng (without this series):

root@virtme-ng:/home/ubuntu/sched_ext/tools/sched_ext# ./build/bin/scx_qmap
libbpf: prog 'qmap_dequeue': BPF program load failed: -EACCES
libbpf: prog 'qmap_dequeue': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags) @ scx_qmap.bpf.c:467
0: (79) r2 = *(u64 *)(r1 +0)
func 'dequeue' arg0 has btf_id 115922 type STRUCT 'task_struct'
1: R1=ctx() R2=trusted_ptr_task_struct()
1: (79) r4 = *(u64 *)(r1 +8)          ; R1=ctx() R4=scalar()
; __sync_fetch_and_add(&qa.nr_dequeued, 1); @ scx_qmap.bpf.c:471
2: (18) r1 = 0x10000fff9000           ; R1=scalar()
4: (18) r3 = 0x10000fff9000           ; R3=scalar()
6: (07) r3 += 32                      ; R3=scalar()
7: (bf) r5 = addr_space_cast(r3, 0, 1)        ; R3=scalar() R5=arena
8: (b7) r3 = 1                        ; R3=1
9: (b7) r0 = 1                        ; R0=1
10: (db) r0 = atomic64_fetch_add((u64 *)(r5 +0), r0)          ; R0=scalar() R5=arena
11: (18) r5 = 0x100000000             ; R5=0x100000000
; if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC) @ scx_qmap.bpf.c:472
13: (5f) r4 &= r5                     ; R4=scalar(smin=smin32=0,smax=umax=0x100000000,smax32=umax32=0,var_off=(0x0; 0x100000000))
14: (15) if r4 == 0x0 goto pc+3       ; R4=0x100000000
; __sync_fetch_and_add(&qa.nr_core_sched_execed, 1); @ scx_qmap.bpf.c:473
15: (07) r1 += 48                     ; R1=scalar()
16: (bf) r1 = addr_space_cast(r1, 0, 1)       ; R1=arena
17: (db) r3 = atomic64_fetch_add((u64 *)(r1 +0), r3)          ;
; QMAP_TOUCH_ARENA(); @ scx_qmap.bpf.c:247
18: (18) r1 = 0xff110001062b6800      ; R1=map_ptr(map=arena,ks=0,vs=0)
; v = bpf_task_storage_get(&task_ctx_stor, p, 0, 0); @ scx_qmap.bpf.c:249
20: (18) r1 = 0xff11000105cafc00      ; R1=map_ptr(map=task_ctx_stor,ks=4,vs=8)
22: (b7) r3 = 0                       ; R3=0
23: (b7) r4 = 0                       ; R4=0
24: (85) call bpf_task_storage_get#156        ; R0=map_value_or_null(id=1,map=task_ctx_stor,ks=4,vs=8)
; if (!v || !v->taskc) @ scx_qmap.bpf.c:250
25: (15) if r0 == 0x0 goto pc+77      ; R0=map_value(map=task_ctx_stor,ks=4,vs=8)
26: (79) r7 = *(u64 *)(r0 +0)         ; R0=map_value(map=task_ctx_stor,ks=4,vs=8) R7=scalar()
27: (15) if r7 == 0x0 goto pc+75      ; R7=scalar(umin=1)
28: (bf) r8 = addr_space_cast(r7, 0, 1)       ; R7=scalar(umin=1) R8=arena
; if (taskc && taskc->fifo) { @ scx_qmap.bpf.c:476
29: (79) r9 = *(u64 *)(r8 +24)        ; R8=arena R9=scalar()
30: (15) if r9 == 0x0 goto pc+72      ; R9=scalar(umin=1)
; if (taskc->highpri) @ scx_qmap.bpf.c:477
31: (71) r1 = *(u8 *)(r8 +45)         ; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R8=arena
32: (56) if w1 != 0x1 goto pc+9       ; R1=1
33: (b7) r1 = 1                       ; R1=1
; __sync_fetch_and_sub(&qa.nr_highpri_queued, 1); @ scx_qmap.bpf.c:478
34: (87) r1 = -r1                     ; R1=-1
35: (18) r2 = 0x10000fff9000          ; R2=scalar()
37: (07) r2 += 88                     ; R2=scalar()
38: (bf) r2 = addr_space_cast(r2, 0, 1)       ; R2=arena
39: (db) r1 = atomic64_fetch_add((u64 *)(r2 +0), r1)          ; R1=scalar() R2=arena
; struct qmap_fifo __arena *fifo = taskc->fifo; @ scx_qmap.bpf.c:299
40: (79) r9 = *(u64 *)(r8 +24)        ; R8=arena R9=scalar()
; if (!fifo) @ scx_qmap.bpf.c:302
41: (15) if r9 == 0x0 goto pc+61      ; R9=scalar(umin=1)
; lock = qa_q_lock(fifo->idx); @ scx_qmap.bpf.c:305
42: (bf) r2 = addr_space_cast(r9, 0, 1)       ; R2=arena R9=scalar(umin=1)
43: (61) r1 = *(u32 *)(r2 +16)        ; R1=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R2=arena
; switch (qid) { @ scx_qmap.bpf.c:110
44: (66) if w1 s> 0x1 goto pc+8       ; R1=scalar(smin=0,smax=umax=0xffffffff,smax32=1,var_off=(0x0; 0xffffffff))
45: (18) r6 = 0xff11000105caf1e8      ; R6=map_value(map=.data.qa_q_lock,ks=4,vs=4)
47: (16) if w1 == 0x0 goto pc+17      ; R1=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,smax32=1,var_off=(0x0; 0xffffffff))
48: (16) if w1 == 0x1 goto pc+1 50: R2=arena R7=scalar(umin=1) R8=arena R9=scalar(umin=1) R10=fp0
; switch (qid) { @ scx_qmap.bpf.c:110
50: (18) r6 = 0xff11000105caede8      ; R6=map_value(map=.data.qa_q_lock,ks=4,vs=4)
52: (05) goto pc+12
65: (7b) *(u64 *)(r10 -16) = r2       ; R2=arena R10=fp0 fp-16=arena
; if (bpf_res_spin_lock(lock)) { @ scx_qmap.bpf.c:193
66: (bf) r1 = r6                      ; R1=map_value(map=.data.qa_q_lock,ks=4,vs=4) R6=map_value(map=.data.qa_q_lock,ks=4,vs=4)
67: (85) call bpf_res_spin_lock#69027         ; R0=0
68: (16) if w0 == 0x0 goto pc+9       ; R0=0
; if (taskc->fifo != fifo) { @ scx_qmap.bpf.c:310
78: (79) r1 = *(u64 *)(r8 +24)        ; R1=scalar() R8=arena
79: (1d) if r1 == r9 goto pc+1 81: R6=map_value(map=.data.qa_q_lock,ks=4,vs=4) R7=scalar(umin=1) R8=arena R10=fp0 fp-16=arena
; bpf_res_spin_unlock(lock); @ scx_qmap.bpf.c:311
81: (79) r2 = *(u64 *)(r8 +16)        ; R2=scalar() R8=arena
; if (taskc->q_next) @ scx_qmap.bpf.c:315
82: (79) r1 = *(u64 *)(r8 +8)         ; R1=scalar() R8=arena
83: (15) if r1 == 0x0 goto pc+4       ; R1=scalar(umin=1)
84: (bf) r3 = addr_space_cast(r1, 0, 1)       ; R1=scalar(umin=1) R3=arena
; taskc->q_next->q_prev = taskc->q_prev; @ scx_qmap.bpf.c:316
85: (7b) *(u64 *)(r3 +16) = r2        ; R2=scalar() R3=arena
; if (taskc->q_prev) @ scx_qmap.bpf.c:319
86: (79) r2 = *(u64 *)(r8 +16)        ; R2=scalar() R8=arena
; taskc->q_next->q_prev = taskc->q_prev; @ scx_qmap.bpf.c:316
87: (05) goto pc+2
; fifo->tail = taskc->q_prev; @ scx_qmap.bpf.c:318
90: (07) r7 += 8                      ; R7=scalar()
; if (taskc->q_prev) @ scx_qmap.bpf.c:319
91: (15) if r2 == 0x0 goto pc+3       ; R2=scalar(umin=1)
92: (bf) r2 = addr_space_cast(r2, 0, 1)       ; R2=arena
; taskc->q_prev->q_next = taskc->q_next; @ scx_qmap.bpf.c:320
93: (7b) *(u64 *)(r2 +8) = r1         ; R1=scalar(umin=1) R2=arena
94: (05) goto pc+2
; fifo->head = taskc->q_next; @ scx_qmap.bpf.c:322
97: (b7) r1 = 0                       ; R1=0
; taskc->q_prev = NULL; @ scx_qmap.bpf.c:324
98: (7b) *(u64 *)(r7 +16) = r1
R7 invalid mem access 'scalar'
processed 70 insns (limit 1000000) max_states_per_insn 1 total_states 5 peak_states 5 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'qmap_dequeue': failed to load: -EACCES
libbpf: failed to load object 'scx_qmap'
libbpf: failed to load BPF skeleton 'scx_qmap': -EACCES
[SCX_BUG] scx_qmap.c:193 (Permission denied)
Failed to load skel

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  tools/sched_ext: always define bpf_addr_space_cast
  tools/sched_ext: scx_qmap: fix arena stores

 .../include/scx/bpf_arena_common.bpf.h        | 21 +++--
 tools/sched_ext/scx_qmap.bpf.c                | 85 +++++++++++++------
 2 files changed, 71 insertions(+), 35 deletions(-)

--
2.48.1

