Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522821;
	b=GVUDM0VGgd36qu2px6H3dQqHiBaa7LLTYYI0QzYLsGKhBxmKlFOBkVjQgUa1j099XN83
	 68LWYcjAbG5TEw1Ep6BPtKdjGMQnMqn4xnfVKQyvXZzvLUSH1bzVJ8MOpdbbYA6QKH3lX
	 mFsITPgdt7AMLQyLnyGFqoYEMaxCQEUUe5AbsVCz5jP8wK5N2soGzHvVHo889oe7AetBW
	 jo71vA6iUB+H8q1uxp+nke8sTQjXFuoIU5iexSE5rcjgCJ/XPlH6SSHSPvvJvfe5lmyLj
	 RSjjjsbjYUBtcJScWiTz/jMErfwJNNj+rApazZqCETrnrUf+TpxVWSgkfYfQ5VyhXfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522821;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=lgkDz6HUhM8jgb8b71HsHBngoPIuP4S4i7blBH75xRo=;
	b=k/BkJIJsk53PFJFOz2FfOtLwI/a2fs7iLKrqV/mXaIoGuCsgMDDpfIfZQ2CSHrds89KI
	 T1fpDl9w0C+jOVKEeIGyFvNbKu7Ug1x/5GMVbGt6IyTT7RATKU5WSOstIibosqd+jxLyH
	 77HCyWV+8kqZgUcveozmTFrPHEcL1J7uDtgg1wubMX1Oe3WfYpezg2VfZT/HG1ONXsvXA
	 kQIstEzKtM13eagmxrMSDZO3QgLo1FUxVHWR+vxMSPF/HZx6JNxNNSgXhH2Cq0moqXdPI
	 ssidGxgzO0j9v4xvUWISXIry4AOIq/EQs+MWGGPHI0MrlR9wmnhFncd8WUNoGfkdoqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B6fb3D/J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA95606A329;
	Tue, 20 Oct 2026 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6fb3D/J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B1A1F000D3;
	Tue, 20 Oct 2026 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522821;
	bh=lgkDz6HUhM8jgb8b71HsHBngoPIuP4S4i7blBH75xRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B6fb3D/JC1mAn4582Gu3ax6JNQ8HMxiyYGpSk5MuFjlaUDlqg96EbhNNnX/c3PloV
	 BUun5EMS4M3znOwG/0UHC18dyoP+ejvM/oS7Xw6m+H+gTvd3Dsdmpbcr++jGNeHK4+
	 R6aTQ9UTMpJVb6bNM4WyvZrC8OO7PKO6iuAyx9uSbGy9cH0xFc5w5IFxSf461zDjdS
	 xs2rgOIPHBV7/sVBDMKxpbPE/1PIkGe2uTRXRRuBuQ12iE/Kzn3aiQPYuG2rRq9ZRo
	 HhiRGpRwhYf7wLM2hTIAk1RwJnHtDGzAOdCVmbDiqb6i6zl8JpeWskmAPz4CHSHexd
	 f5H4IMvrSRhsg==
Date: Tue, 20 Oct 2026 09:00:20 -1000
Message-ID: <ba9d879aa8b0474d09577b82a1d68940@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH sched_ext/for-7.4 0/5] sched_ext: Make ops.cpu_acquire/release() reliable
In-Reply-To: <DM9V2QCIFVGI.3VSJXUCU94ICW@google.com>
References: <cover.1792248922.git.jpiecuch@google.com> <20261019144807.1207781-1-jpiecuch@google.com> <657547efeaea54276c50a0c106399366@kernel.org> <DM9V2QCIFVGI.3VSJXUCU94ICW@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello, Kuba.

On Tue, Oct 20, 2026 at 06:02:36PM +0000, Kuba Piecuch wrote:
> That's true if the only thing you do from ops.cpu_release() is
> re-enqueue the local DSQ. It may not be true if you're trying to do
> other things like e.g. kicking the sibling CPU in scx_pair.
>
> Fixing ops.cpu_release() would let us get rid of the sched_switch hack
> in scx_pair, which we know isn't perfect at detecting CPU preemption
> by a higher sched_class.

What I don't like about ops.cpu_acquire/release() is that they track
whether the CPU is occupied by a sched_class higher than SCX, which seems
a bit out of scope for a sched_class. Wanting to know that is fine, but
it's global system state and would be better tracked by hooking into
system events than built into sched_ext. I don't think the
acquire/release semantics are a good fit for it either.

> Part of my motivation is Google's BPF schedulers, which are composed
> of subschedulers, and we explicitly track which CPU is owned by which
> subscheduler. Having a reliable CPU preemption callback would help with
> porting them over to sched_ext.

If sched_switch isn't enough, how about adding a tracepoint which tracks
the sched_class currently in effect on each CPU? That should cover both
scx_pair and your use case, and would be useful outside sched_ext too.

Thanks.

--
tejun
