Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE83A9DB2
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951877; cv=none; b=SccuDt3gnhYHzX9Ry9eK8QNdn71UaPQtfO0ZG3kD7cZ62TxsS7B+PKXlFsyW12k85rTT619iDlWT8l6fd1aNslfusUxDK0yQDvhk32EdvSqHlsVnDCXD10zb+1Dm4r6GOiXoYSerZqLzGSsau5mptWUrE+ScHWIcxXYKFgic9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951877; c=relaxed/simple;
	bh=qf79dsGxljK/ChzeP8QYAOMTPS7kDxoY57yCXsNl7kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzAKZuQKwosHr7FhHkzONFv4P97LhmzR5fQGko9tzkscPYmhPV5S92ZUiMMxF2RpWZA0eETnYH6VlqAqAbUz7HLq1WejCiyL9Pq32kQAJORw/zt1r4ia7f3vdqqYkrV9EqIooU8G7nfFfJmHEVp4h5YWmq0UHqZSZBj9zIU8ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YrMc2xK6; arc=none smtp.client-ip=91.218.175.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YrMc2xK6"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=qf79dsGxljK/ChzeP8QYAOMTPS7kDxoY57yCXsNl7kY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791951873; v=1; x=1792556673;
 b=YrMc2xK6ClNLnkQCsgHh9Ccrxn0cNS+ObscvCamkut61P6FcwVxRW5DrxPKVs+i7DIWrs5rh
 QFbPg+gkAyTSfrHwd7W8DUoipv61fRQboYzPf5D9xQ4D9ixPHhmGQVnFpm68WZJaLMgVes8daR7
 2SdeVSOwxMe2GyxF7jdKLHsE=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id a3bc8871b557cebd;
	Wed, 14 Oct 2026 04:24:33 +0000
X-Mizu-Trace-ID: a3bc8871b557cebd
X-Migadu-Flow: FLOW_OUT
Message-ID: <e0cdb928-5e4d-487e-90ca-694a11b4ade1@linux.dev>
Date: Wed, 14 Oct 2026 12:24:29 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPORT] sched_ext: sub-scheduler tasks are severely
 under-scheduled vs root-owned tasks
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, sched-ext@lists.linux.dev,
 Andrea Righi <arighi@nvidia.com>, linux-kernel@vger.kernel.org,
 Changwoo Min <changwoo@igalia.com>
References: <163e2397-0e3e-4cc0-842b-0d36598d13d7@linux.dev>
 <68208eef89abff9423de730ef585327f@kernel.org>
 <3e044142-8f2c-45a2-8d5f-75d301526023@linux.dev>
 <14824587e8eb436b2621fef1bb681cce@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <14824587e8eb436b2621fef1bb681cce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello， Tejun

在 2026/10/10 7:42, Tejun Heo 写道:
> Hello, Tao.
> 
> The following is a Claude-generated analysis.
> 
> On Fri, Oct 09, 2026 at 09:51:35AM +0800, Tao Cui wrote:
>> The scheduler is a single binary (scx_k2) with parent/root and
>> child/sub modes. The parent grants SCX_CAP_PERF | SCX_CAP_ENQ_IMMED
>> to the child over a cgroup, while the child only writes cpuperf
>> target 1 from ops.tick(). Both schedulers print their counters every
>> 2s.
> 
> Reproduced on for-7.4 with your sources in a 4 cpu VM. The starvation
> comes from the two schedulers, not the kernel.
> 
> The child's ops.enqueue() inserts every task into its own user DSQ. The
> only consumer of that DSQ is the child's ops.dispatch(), and a child's
> dispatch runs only when its parent calls scx_bpf_sub_dispatch() from its
> own ops.dispatch(). scx_k2's parent never does. See the comment above
> enum scx_cap_flags in kernel/sched/ext/internal.h and how scx_qmap
> dispatches its children. The SysRq-D dump during the stall shows the
> spinner in the child's DSQ 0 with a full slice while cpu0 runs root
> tasks.
> 
>> In an A/B test, having the parent kick the task's CPU from
>> ops.enqueue() with scx_bpf_kick_cid() and hand its dispatch turn to
>> the child with scx_bpf_sub_dispatch() prevents the starvation.
> 
> scx_bpf_sub_dispatch() is only callable from ops.dispatch(). With the
> parent calling it there, the child's dispatch does run, but every
> scx_bpf_dsq_move_to_local() is rejected because the grant lacks
> SCX_CAP_ENQ. SCX_CAP_ENQ_IMMED only covers IMMED inserts. The task goes
> to the reject DSQ and is reenqueued, SCX_EV_REENQ_REPEAT climbs on the
> child, and it still starves. With the sub dispatch call and SCX_CAP_ENQ
> granted as well, the spinner runs at full duty under the child.
> 
>> Actual: the child claims the task, and its ops.tick() initially
>> services it, but setcnt then stops increasing and the task receives
>> little or no CPU time - 0-91 ticks per 6s window across our runs,
>> most rounds 0.
> 
> The initial burst is the bypass DSQ drained during attach. In the
> move-after-attach order the task keeps running through dispatch's
> keep-last path until something else wakes on cpu0 and pushes it through
> the child's ops.enqueue(), which is why some windows look healthy. The
> stall watchdog catches it past your 6s window:
> 
>   sched_ext: BPF sub-scheduler "k2" disabled (runnable task stall)
>   sched_ext: k2: sh[1401] failed to run for 30.696s
> 
>> One possibility is that, on a NO_HZ idle CPU, no balance is
>> triggered for the child's DSQ, so the child's ops.dispatch() is
>> never called.
> 
> The parent's dispatch on cid 0 ran several times a second throughout
> the stall. It only consumed the parent's own DSQ.
> 

Thanks a lot for taking the time to reproduce this and for the detailed
analysis.

I completely missed that the child's ops.dispatch() only runs when the
parent explicitly delegates to it with scx_bpf_sub_dispatch(). I had
been assuming the core would eventually route balance to the child once
it owned the task, so I ended up chasing the wrong direction.

The SCX_CAP_ENQ vs SCX_CAP_ENQ_IMMED distinction also explains why my
A/B experiment wasn't actually proving what I thought it was. I hadn't
noticed that scx_bpf_dsq_move_to_local() requires SCX_CAP_ENQ, so the
reject/reenqueue path makes perfect sense now.

I'll update the scheduler to dispatch to the child as intended and
grant SCX_CAP_ENQ where appropriate, then rerun the tests.

Thanks again for the thorough explanation and for pointing me to the
internal.h comments and the scx_qmap implementation.

--
Tao

> Thanks.
> 

