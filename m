Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811384;
	b=ALlNOray9Oj65NMw1pJQdfngBJQVRTRm7Kr1da2EK6SpD0cDHSQnDAjWkE6SmWq2VL64
	 9VmT0rxUi8YCXuKU5eqr2K7+75/8UMtClKqPTPDq/0lptyEedIzxvBP7rJNtguTuN7iGX
	 83eN86nvlNymq/Z7GGA11DxBQ2L64z9Y+WUo0VSKgN6EA3SIrbPf7bz2wIvVEw6/n/T5N
	 pYXx1GXYSIhDVl2VcZzu81IIypQI9nyqSZtwxP7pjqnoD7g3bfce40th9LluCWLBTZENE
	 xM/CncAGeQXZ96UTzETr/fu0Ju80goGhev9B1dM3zR8x+Kzdm92F9KOgTp4tQy+Dp4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811384;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pEnJneC/8wobpaicNRz2z42TcqLgY9bjiYBL8Bq4n7E=;
	b=ckJiAK/ozvGeAK3eVevr1j/yXEOh8gMOqypwhaBeUhWhWim4n3ZvmxpvzASuCn2S0tcv
	 iTdfcY9NZBnClWH4uzIYl9Ds/4TtZAgoilTS1rYn5o9WfQd639P50xj2ThCV2xRRJx49L
	 TrPN59DldHzo4vdlVuCoiQaHSspQjst9kNE0DkCU7h7iKXwzot1Fgkl4kFcpBn+qTzORJ
	 RpokPOkNyuS7PuSk47A/W1VRvsBbYF54ih7NTAXbbCP3R0i1aXJiesG10KV1gcMIta+mM
	 B+S8MmiiF2nWEi0wr3dcbxBjxQJ9qVAck3ZigGswLLW+PP6oO//56yHiJs/Q00GW3fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0CR9w46;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF629606A31C;
	Fri, 27 Nov 2026 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0CR9w46
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C6D1F000C1;
	Fri, 27 Nov 2026 20:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811384;
	bh=pEnJneC/8wobpaicNRz2z42TcqLgY9bjiYBL8Bq4n7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i0CR9w46oAjCWAxU94XRlwV6tKekSS0QmU7V8Eh9Gb9tl509RrO8XtUOPZWOcLNI5
	 L/nC2B0JZT2CuStEreroq2MDKpK75CRcoDlYYTY9Ees+a03KFGmHMHuwjiwAOZd/di
	 jTJsldOenzQZgBA5BUlPszcETZW7ZP3XmKbOkfERGSPszWYrkfAhDSRrrb1c6S3kAJ
	 +JHpQG2hrEKcjtoD6ylBgtwNfYaYQPZscczqbwR4/aq2lB92Np6ZxcAjQUdvq86k1s
	 LppDcoxrbxnVmP+79YNRSQf9h1yged0kMCWSo3svwFeG4XuSGksoldCfRrEqY4OwgC
	 kdy9FP1U+LGaQ==
Date: Fri, 27 Nov 2026 10:29:43 -1000
Message-ID: <0e09857f3adcb5a83711458cd7d1b6f9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, John Stultz <jstultz@google.com>, David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Tao Cui <cuitao@kylinos.cn>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched_ext: Make SCX_OPS_ENQ_BLOCKED a hierarchy-wide setting
In-Reply-To: <20261126111649.208476-3-arighi@nvidia.com>
References: <20261126111649.208476-1-arighi@nvidia.com> <20261126111649.208476-3-arighi@nvidia.com>
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

Hello, Andrea.

On Thu, Nov 26, 2026 at 12:13:58PM +0100, Andrea Righi wrote:
> Mixing proxy donor admission within a hierarchy has no real use, so
> don't allow it: a sub-scheduler must match the root scheduler's
> SCX_OPS_ENQ_BLOCKED setting or it fails to load.

Does the match need to go both ways? If the root sets SCX_OPS_ENQ_BLOCKED,
proxy execution is on and every sub-sched needs the flag too. However, when
the root doesn't set it, I don't see why a sub-sched which sets it can't be
loaded. Proxy execution can just stay disabled.

The root alone would then decide whether blocked donors are admitted, and
scx_allow_proxy_exec() can become a static key which is determined by the
root sched.

Thanks.

--
tejun
