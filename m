Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352171;
	b=wnBTAme5Xvbqm3PP4T0powCwhWyCYPzaOLn53kwh0v0psSRhAT8Hg5bViq8Tdywxvby5
	 8jpenamOiTrmbDMkdN7R/sbvWvgl3gFk0K9aOzfYtTKKhF2dWJFPd63mjWsaPhfHNcIfP
	 zxWF3aGODcCQe7jMxSa590vxryy1d59h0qlpdQlxBbDLvhASz5s31aeeoG+VsZdLNGbR4
	 48j93GSRGOTjYXTwSEtftEQJ3ZKDl7lg9XhR8vukFIjiOv7+KYWvvRnJUd+20ZOR5XHpd
	 WZvtGvsEXYjUixXn/DeKJuln+OWHRHxOf+30maPfW95IK3l0teePZKc+VleMnb7hD8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352171;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=TkCOrFNfCxpRc85ogd6l1q1ueIhyoTGwTSv5WtrZ9a8=;
	b=tYcv+tMqAD9d8vL5EAXBgrYLNCYm3s4VdVtOrRpoW+7u9Oz0vSDE2zSwGcsZ7FK5EP9q
	 Mpzz1JsEJe5uXDBqm5ElbWm1jkfYQHhFOw27zTDJpW5hUuwM8PY9lBs8AMid2W1j3amqx
	 gI0ossn9or9qOQ+QbRUDX2qMWfTQf+Kf+9OObwo/kfOJsbqBJ/+p28g6Z4jiUCbGeBOwB
	 q8eA07jp+dzXBLBOOu8ionZX3ab5NmqEB1Bey01Jrjqo/EUc8YInsY38AmVeEAIgGKK0d
	 6zFXZJ1dMGyZ645YDKGfmkDkvwSZljw4hgGI54NkfjKLtnKrTaOk617uK+QaPAnvwMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h0nWS9mE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE4606A31D
	for <sched-ext@lists.linux.dev>; Fri, 30 Oct 2026 09:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86AE4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h0nWS9mE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793352169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkCOrFNfCxpRc85ogd6l1q1ueIhyoTGwTSv5WtrZ9a8=;
	b=h0nWS9mEMhKiy0NSDzp6/93kdJ6DZg0IV2p2dggZ6c5PzslWNdYSPSTh0xGR6GxKaetZD0
	9rxZOwhBOyiHNtDABobp0WSzPdVfBLO96hL9tUH6SSd5WJZSx9vdV4UKqZLACqYZNjOeI+
	hjR0xYFyLtiFngY9km0C9TCrpHq3Eno=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-WIMBalTIMMqkh4kEansZHw-1; Fri, 30 Oct 2026 05:22:47 -0400
X-MC-Unique: WIMBalTIMMqkh4kEansZHw-1
X-Mimecast-MFC-AGG-ID: WIMBalTIMMqkh4kEansZHw_1793352167
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e20ed362aso13716f8f.2
        for <sched-ext@lists.linux.dev>; Fri, 30 Oct 2026 02:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793352166; x=1793956966;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TkCOrFNfCxpRc85ogd6l1q1ueIhyoTGwTSv5WtrZ9a8=;
        b=QV3UWYJFGrgQNbk0+wJzeSelUQg64I+4gMkbGzRqbG0rxEii/X1sw7A1D20sChKx5F
         6L3iEFKjCLQbj6qSXF5Di2h9qMfPTypFIKeNurFbqBdyBLaN+P0lAxnbCm7Lm0Knz+Gp
         bm2lXgrpBm+SGz3yNrJB8tlzbDMlqvycC++4OubuX/c+VFAJxTvkY2fUqzzjL15B+tql
         Usk5+UAi/4Cza84dPmChGvuljiRXN911FQcGHPwSwjycYIxi3IsMOwsh0c9h3dNDN4x/
         IFv1wg7cBvMCH3oHQeEVEPC3tfDx7qIkeb3gN17y0BTHdyNHSsdMQ35NQEYvFUBfVbf4
         ySQg==
X-Forwarded-Encrypted: i=1; AKwUvBxpTaACQNPU0flF5T+CcApARMnCZbqeA+v3y3Dmhc9mhy9+dsOtWXiseAn0jHZxhqur/5nqVYcE6ek=@lists.linux.dev
X-Gm-Message-State: AFq9FYJ1UZrXtx6ra5S4sj3r17KdIqNOdgSOI8JWc2InI4wM6fIJcv+B
	2KuN40iAadm3u3Pbe0DSGoiaDnKURSK/frBtr4tB6QLArL4mCGrI3kFkb0eEtUPchULWTR7VCqY
	EnvW/v0ZB1MrRQshL99+DFivMmtzGx0jBiaOoZMt2yXxmPD6ps4nGF3l9ihDLkQ==
X-Gm-Gg: AYBFou3niUo77XH99jlqj54pkdvo/Ge8SejJHznAvSNjaYv7JmdIfG93SGDlCV0OAmH
	2srf8V7RXH/vLKJ3UpSVGk05IzHFGk/qR4Ymcpmyi9WIzo3x1qof6mOIPLPLqTE02kVxpZKD5Z/
	2XG1Xhg3K2IO2wDdHFv/XB3sMuKI4JMNSstQGW+YoRoT2UQEkYw4hkjrTdGD0HFJjKI0fMqVABt
	vWE751a73qwy3oeFftoVWct/F8ZgGL64T2yWMwD4RjSz4KTInRrCF5tUjvoxcBw079+HQBZFQ9V
	UnkEf8vL+eU1/VWl2GtZKFLKSp2057Gcb1MJm/kOtJ6lw3RIlkfWPdlL3iryf0RL1Ry4r1Fs7/u
	Zr9QvU4wjkyXAH6iDETJ0chMnQsu8c1dlc063FFISkDEXMRomchtBSD10Ce35QEBFKTFvCTJ0Ei
	SgdT4=
X-Received: by 2002:a05:6000:2306:b0:486:f907:ebec with SMTP id ffacd0b85a97d-48e6e303c80mr3746371f8f.31.1793352166492;
        Fri, 30 Oct 2026 02:22:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2306:b0:486:f907:ebec with SMTP id ffacd0b85a97d-48e6e303c80mr3746333f8f.31.1793352166097;
        Fri, 30 Oct 2026 02:22:46 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.0.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba5dc2sm2083851f8f.54.2026.10.30.02.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:22:45 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:22:43 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: sched/deadline: total_bw leak when a task leaves SCHED_DEADLINE
 while not queued
Message-ID: <auRh42kZI1xLIWNr@jlelli-thinkpadt14gen4.remote.csb>
References: <2b5fb3f22bca6aa383be8f4781923392@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <2b5fb3f22bca6aa383be8f4781923392@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QiFtAlziovUr7qRF39zy6qLidaZqMofw79gN_RGhv60_1793352167
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 29/10/26 11:55, Tejun Heo wrote:
> Hello,
> 
> A SCHED_DEADLINE task that is switched to another policy while it isn't
> queued (sleeping, or stopped with SIGSTOP) leaves its bandwidth in the root
> domain's total_bw. The bandwidth stays after the task exits. The leak
> happens as follows.
> 
> 1. sched_dl_overflow() doesn't subtract the bandwidth of a task leaving
>    DEADLINE and leaves that to switched_from_dl().
> 2. switched_from_dl() calls task_non_contending() only for a queued task.
>    task_non_contending() releases the bandwidth right away if the 0-lag time
>    has passed and otherwise arms the inactive timer, and
>    inactive_task_timer() releases it once the task is no longer dl_task().
> 3. For a task that isn't queued, the bandwidth is released only if its
>    inactive timer is still pending from its dequeue. No timer is pending if
>    the task never ran as DEADLINE, or if it already fired while the task
>    slept. In the latter case the task was still DEADLINE when the timer
>    fired, so it only dropped running_bw. Either way, nothing releases the
>    bandwidth.
> 
> Repeating it fills total_bw up to the admission cap. After that,
> sched_setattr(SCHED_DEADLINE) and CPU offline fail with -EBUSY, and so does
> enabling a sched_ext scheduler, because attaching the ext dl_server
> bandwidth fails:
> 
>   sched_ext: failed to attach ext_server on CPU 0 (-16)
>   sched_ext: simple: scx_root_enable() failed (-16)
> 
> The reproducer below needs root and debugfs, and assumes x86-64 for the
> syscall number 314.
> 
>   import ctypes, os, signal, time
>   libc = ctypes.CDLL(None, use_errno=True)
>   class SchedAttr(ctypes.Structure):
>       _fields_ = [("size", ctypes.c_uint32), ("policy", ctypes.c_uint32),
>                   ("flags", ctypes.c_uint64), ("nice", ctypes.c_int32),
>                   ("prio", ctypes.c_uint32), ("runtime", ctypes.c_uint64),
>                   ("deadline", ctypes.c_uint64), ("period", ctypes.c_uint64)]
>   def setattr_(pid, policy, runtime=0, period=0):
>       a = SchedAttr(ctypes.sizeof(SchedAttr), policy, 0, 0, 0, runtime, period, period)
>       if libc.syscall(314, pid, ctypes.byref(a), 0):      # sched_setattr
>           raise OSError(ctypes.get_errno(), "sched_setattr")
>   def total_bw():
>       s = open("/sys/kernel/debug/sched/debug").read().split("dl_rq[0]:")[1]
>       return int(s.split("dl_bw->total_bw")[1].split(":")[1].split()[0])
>   def trial(name, body, stop=False):
>       pid = os.fork()
>       if pid == 0:
>           if body == "spin":
>               while True:
>                   pass
>           while True:
>               time.sleep(3600)
>       time.sleep(0.05)
>       bw0 = total_bw()
>       setattr_(pid, 6, runtime=2_000_000, period=10_000_000)  # DEADLINE 2ms/10ms
>       if stop:
>           os.kill(pid, signal.SIGSTOP)
>           time.sleep(0.02)
>       setattr_(pid, 0)                                         # back to OTHER
>       os.kill(pid, signal.SIGKILL)
>       os.waitpid(pid, 0)
>       time.sleep(0.05)
>       print(f"{name:24s} leaked total_bw {total_bw() - bw0:7d} (0.2 CPU = 209715)")
>   trial("sleeping dl>other", "sleep")
>   trial("stopped dl>other", "spin", stop=True)
>   trial("running dl>other", "spin")                            # control
> 
> On mainline 4dd16e31135e it prints:
> 
>   sleeping dl>other        leaked total_bw  209715 (0.2 CPU = 209715)
>   stopped dl>other         leaked total_bw  209715 (0.2 CPU = 209715)
>   running dl>other         leaked total_bw       0 (0.2 CPU = 209715)

Thanks for reporting and for the reproducer!

Does the below help?

Best,
Juri

---
 kernel/sched/deadline.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c0ebdcde5fe5d..5a51368bfc70a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3530,14 +3530,31 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	dec_dl_tasks_cs(p);
 
 	if (!task_on_rq_queued(p)) {
-		/*
-		 * Inactive timer is armed. However, p is leaving DEADLINE and
-		 * might migrate away from this rq while continuing to run on
-		 * some other class. We need to remove its contribution from
-		 * this rq running_bw now, or sub_rq_bw (below) will complain.
-		 */
-		if (p->dl.dl_non_contending)
+		if (p->dl.dl_non_contending) {
+			/*
+			 * Inactive timer is armed. However, p is leaving
+			 * DEADLINE and might migrate away from this rq while
+			 * continuing to run on some other class. We need to
+			 * remove its contribution from this rq running_bw now,
+			 * or sub_rq_bw (below) will complain.
+			 *
+			 * inactive_task_timer() will find !dl_task(p) and
+			 * release total_bw via __dl_sub().
+			 */
 			sub_running_bw(&p->dl, &rq->dl);
+		} else {
+			/*
+			 * No pending inactive timer: the task never ran as
+			 * DEADLINE or the timer already fired while still
+			 * DEADLINE (only dropping running_bw at that time).
+			 * Nobody else will release total_bw, do it now.
+			 */
+			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
+
+			raw_spin_lock(&dl_b->lock);
+			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
+			raw_spin_unlock(&dl_b->lock);
+		}
 		sub_rq_bw(&p->dl, &rq->dl);
 	}

