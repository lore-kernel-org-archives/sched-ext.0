Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3AE4582D8
	for <sched-ext@lists.linux.dev>; Thu, 10 Sep 2026 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037462; cv=none; b=bOURcEXg6jSpwPJHyaVGIEGbYGN5+vbFpKKVtVL+rUdu9AAb8GxYAPcG8uZcQWZ2UbrSPK7EaGU1qk2kVgJ2ofraiJDo1okE2q3IKt5CiHtkLsX2ryYA2LUzB62MwHsmOtHEuhfHD0+vba3qfadMBsLf4onbe65Ql5V/83Q97CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037462; c=relaxed/simple;
	bh=5hQWqlOjQvOgrULRNQNvsDrFTg3ZUp9uEWavniukEpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceRx9qBM8CU4L8uXOn4ZDQitrNQ1hs4W1telbnD25XjVlt89Ad0WEk7iWfPKo2DNuI6/0KDAKm5DmG997GYM97c7Vr3JDxxUKYIdWWKEiQkaDVHh+qWN2NlWk6Fwv8C30I6j2AXoXijEZZYSg3ncgkVtsP9fZp4PJdBn5pp3prE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lmJDR4Z+; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lmJDR4Z+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GR
	7/FIwN5jSXQMlAo82lPv7zwqHGRXa2o1ep2UsTpec=; b=lmJDR4Z+NFUUaAKfX6
	hiFukwvl3FfHXFL/i603dsrsvUb26dkCHPMccCLbKRMawMyGrCcmZ6v8Ds4nwzOa
	Ux7jO4qeJv5Y42nadPr2Qx6PQ0QYckxCJWBEwICCZAv0YYyTXxfyYZDXi+L/a61u
	8Y5preSfJ8GSqwUY8p9XazDIs=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCX1Bw4i6JqOwuKQw--.33571S2;
	Thu, 10 Sep 2026 18:49:29 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: peterz@infradead.org,
	mingo@redhat.com,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	kprateek.nayak@amd.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	connoro@google.com,
	jstultz@google.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v4 1/5] sched: Dispatch task ticks for donor and execution classes
Date: Thu, 10 Sep 2026 19:49:28 +0900
Message-ID: <20260910104928.2771533-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aqGa0J1_LM99oDkP@gpd4>
References: <20260909092901.2989564-2-sh_def@163.com> <20260909104251.3131056-1-sh_def@163.com> <aqGa0J1_LM99oDkP@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCX1Bw4i6JqOwuKQw--.33571S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4xGw4rXF4Utry3Gw4rKrg_yoW5Xr4rpF
	Z5Kay5Kw1DtF1rAr47Zw48X3WrX397Gr1UWrWkArykurWYqry0gFyftF1jva1UWryfuFy2
	vrs0vws7GFWjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNBMNUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6ho0k2qiizrGXwAA33

On Wed, Sep 09, 2026 at 07:43:44PM +0200, Andrea Righi wrote:
> They should be compatible soon:
> https://lore.kernel.org/r/20260831134338.1531664-1-arighi@nvidia.com/
>
> It'd be good to handle SCX donor/execution context ownership in this serie as
> well, or we can coordinate to figure out the required changes.
>
> I haven't looked at the whole patch series yet (will do soon), this is JFYI. :)

Thanks for the heads-up.

I kept task_tick_scx() explicitly donor-gated in the current local draft and
did not duplicate the donor-accounting changes from your v13 series. The common
task_tick() dispatcher invokes the donor class first and, when the execution
class differs, invokes the execution class second. If sched_ext is reached
only as the execution class for a non-EXT donor, task_tick_scx() returns
without SCX policy or slice work.

I previously applied your v13 series and an integration tree containing an
earlier revision of this five-patch series on the same base. In that
integration, the task_tick_scx() hunk was the only textual conflict I
encountered.

The current revision additionally handles retained-donor scheduling-class
transitions around sched_change_begin() and sched_change_end(). Your v13
series also changes that transition path, so I have not revalidated the
combined tree after this latest P4 change. The expected resolution still
uses task_tick(rq, queued), derives the donor from rq->donor, keeps the
explicit donor-class guard, and preserves your donor-based update_curr_scx()
and SCX proxy accounting.

That earlier combined integration tree built and booted with
CONFIG_SCHED_CLASS_EXT=y and CONFIG_SCHED_PROXY_EXEC=y. It did not provide a
stable full mixed EXT->FAIR, FAIR->EXT, EXT->EXT, and RT/DL->EXT runtime
matrix, and it predates the current P4 transition changes. I am therefore
not claiming complete runtime compatibility for the current revision.

The resolved task-tick path in the integration tree is:

  struct task_struct *donor = rq->donor;

  if (donor->sched_class != &ext_sched_class)
          return;

  update_curr_scx(rq);          /* donor-based in your series */
  SCX_CALL_OP_TASK(sch, tick, rq, donor);
  if (!donor->scx.slice)
          resched_curr(rq);

The complete conflict resolution is carried by the integration tree; this
excerpt records the donor guard retained from this series and the donor
accounting retained from yours.

Could you take a look at whether this donor-gated integration is the right
direction? If so, I will revalidate the current combined tree, carry the
result into the series, and post it as v5 after the pending runtime checks.

Thanks,
Hui

