Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310912;
	b=cIGp3XR1sVFbSEw8buEs3n5NodFwDPQvH6CYnggbfH5pKtOodUj+uWNWCfXn2D8cVPgf
	 hn4rrMzo6NX6ehkw2qQ/Ehbc+Izlz3brS2qfq/JhhZSBWO1HP7ZJ1RX0V6nvk2Tp0qCTu
	 ZBt9MXRat7tNMMU5SDiSFSQD+7VwDX0v8dADOgIoGpc7EPlAEishliB0Ab8yRayEJNQZ6
	 7MWOvodD1mrFAGlJq+4lCd5N4gJ/PnUKN01JFuQ8ElarUeKwBeWsliRXixkJmOnQoii5E
	 GucTWKYY4E/iYB82z5V8AuPXJFkNU9Ufz6T4ROaUtqNpoX/s6hkc74b11PvCsi+dB9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310912;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OjNMJiUPO/5Q9v9lrzRxBmS69eP3pYAB5J2qpAy70pE=;
	b=J/aJol8wNfQ42Uko6WL66sfuR+t7XL3o7uSlkJmmPFb2SGvu0V3wsqK2uqMZ+48ibZ/I
	 mQlUmPC3dB2iqaZqBTZJWiRSIpM3N4m5ocuWSBmQbuIpyY48bRHe7K8i/p8HZGBy5GJsH
	 LD7ZtS83amOqyUPNQ2i38TZRYOv6ee/GUUDMo0FZLtcVFEwMc7Qor9KWwsIZLJsubrBLs
	 CtjEvEqdU5Ct9GN/IX9gT4WDHx+jjQbsIVaDjYt7W8ntKewrdN8OGBw7Td/t0rZd4S6lg
	 9nzVboh/cSV/ACTmvE/CV1Y55KPDAe+HZUptSTpHIxoPW2w6ywLkwraV1Q19QNqTlWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvJaDV5+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2F606A31A;
	Thu, 29 Oct 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvJaDV5+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F451F01816;
	Thu, 29 Oct 2026 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793310911;
	bh=OjNMJiUPO/5Q9v9lrzRxBmS69eP3pYAB5J2qpAy70pE=;
	h=Date:From:To:Cc:Subject;
	b=XvJaDV5+vqOCrvB/NEbvKMX0W0d4OjctBtBiwHVNurWhC/k+vG/GX7Iw8pn6vDk04
	 Qr8gMvmN5F65iR0Z06l7Xy5GyLXCf6Kr8V/AD2HB6xFk70msnGvuS5nEcwZr15jYcp
	 AhfMMrauUky4UAdp7QMO7+lqmUWm05A6Uo3veq3rV94LlYL1EjNKh6VV1sErSUBJyO
	 RSVDCtUUNehMj9j+iTSW6wXUlgY6GyCf/ixe6fmjgI5dH8Amam5+X3QqXpIYS3ix3y
	 EExHrCcExRDcVE0+DUHef+apVPh7q2KYDcnODWWzn7lskXWkehms4Imf9B259Gfn2S
	 RSmepVAUUdEYQ==
Date: Thu, 29 Oct 2026 11:55:10 -1000
Message-ID: <2b5fb3f22bca6aa383be8f4781923392@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Luca Abeni <luca.abeni@santannapisa.it>, Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sched/deadline: total_bw leak when a task leaves SCHED_DEADLINE while not queued
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

A SCHED_DEADLINE task that is switched to another policy while it isn't
queued (sleeping, or stopped with SIGSTOP) leaves its bandwidth in the root
domain's total_bw. The bandwidth stays after the task exits. The leak
happens as follows.

1. sched_dl_overflow() doesn't subtract the bandwidth of a task leaving
   DEADLINE and leaves that to switched_from_dl().
2. switched_from_dl() calls task_non_contending() only for a queued task.
   task_non_contending() releases the bandwidth right away if the 0-lag time
   has passed and otherwise arms the inactive timer, and
   inactive_task_timer() releases it once the task is no longer dl_task().
3. For a task that isn't queued, the bandwidth is released only if its
   inactive timer is still pending from its dequeue. No timer is pending if
   the task never ran as DEADLINE, or if it already fired while the task
   slept. In the latter case the task was still DEADLINE when the timer
   fired, so it only dropped running_bw. Either way, nothing releases the
   bandwidth.

Repeating it fills total_bw up to the admission cap. After that,
sched_setattr(SCHED_DEADLINE) and CPU offline fail with -EBUSY, and so does
enabling a sched_ext scheduler, because attaching the ext dl_server
bandwidth fails:

  sched_ext: failed to attach ext_server on CPU 0 (-16)
  sched_ext: simple: scx_root_enable() failed (-16)

The reproducer below needs root and debugfs, and assumes x86-64 for the
syscall number 314.

  import ctypes, os, signal, time
  libc = ctypes.CDLL(None, use_errno=True)
  class SchedAttr(ctypes.Structure):
      _fields_ = [("size", ctypes.c_uint32), ("policy", ctypes.c_uint32),
                  ("flags", ctypes.c_uint64), ("nice", ctypes.c_int32),
                  ("prio", ctypes.c_uint32), ("runtime", ctypes.c_uint64),
                  ("deadline", ctypes.c_uint64), ("period", ctypes.c_uint64)]
  def setattr_(pid, policy, runtime=0, period=0):
      a = SchedAttr(ctypes.sizeof(SchedAttr), policy, 0, 0, 0, runtime, period, period)
      if libc.syscall(314, pid, ctypes.byref(a), 0):      # sched_setattr
          raise OSError(ctypes.get_errno(), "sched_setattr")
  def total_bw():
      s = open("/sys/kernel/debug/sched/debug").read().split("dl_rq[0]:")[1]
      return int(s.split("dl_bw->total_bw")[1].split(":")[1].split()[0])
  def trial(name, body, stop=False):
      pid = os.fork()
      if pid == 0:
          if body == "spin":
              while True:
                  pass
          while True:
              time.sleep(3600)
      time.sleep(0.05)
      bw0 = total_bw()
      setattr_(pid, 6, runtime=2_000_000, period=10_000_000)  # DEADLINE 2ms/10ms
      if stop:
          os.kill(pid, signal.SIGSTOP)
          time.sleep(0.02)
      setattr_(pid, 0)                                         # back to OTHER
      os.kill(pid, signal.SIGKILL)
      os.waitpid(pid, 0)
      time.sleep(0.05)
      print(f"{name:24s} leaked total_bw {total_bw() - bw0:7d} (0.2 CPU = 209715)")
  trial("sleeping dl>other", "sleep")
  trial("stopped dl>other", "spin", stop=True)
  trial("running dl>other", "spin")                            # control

On mainline 4dd16e31135e it prints:

  sleeping dl>other        leaked total_bw  209715 (0.2 CPU = 209715)
  stopped dl>other         leaked total_bw  209715 (0.2 CPU = 209715)
  running dl>other         leaked total_bw       0 (0.2 CPU = 209715)

Thanks.

--
tejun
