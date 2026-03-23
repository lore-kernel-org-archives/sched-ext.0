Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE7D2D8385;
	Mon, 23 Mar 2026 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307602; cv=none; b=VrCfh8taVzqTagN9jteX4D4z5RkL5DmD5UUeuI2/L56wcbwH45091S7mVZNJEP+5Jwb9s4kXsXyVRnRnZeNknSIbkRTieCkmFM9PkF3p/3k5vicP4Di2kF4enZlQpYICSdrHAC7HQ4mnpDNj73/x/sCdlKFfBdbwhAP2/xvO7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307602; c=relaxed/simple;
	bh=5qE+D3jLLabvNJXsPeODJcF/1sCkzowgVrGwwoXC90M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5x4jm6w+J5IMI7OS26NKt4oMIIg4AZ5qmZEzkFr7eR14MEzWQw072Fon4IcSmI0uJUov7oGT+bPMXPNVq62SGHgvhaaKg3/pF8uLziJrrKOzX4IvIUF5TNwVnn71of4A5ILJYRewns3pG9l2tvYva//9qkN0N2jJ9b6YLBXW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/ZfmKxG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/ZfmKxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910EEC4CEF7;
	Mon, 23 Mar 2026 23:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307601;
	bh=5qE+D3jLLabvNJXsPeODJcF/1sCkzowgVrGwwoXC90M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/ZfmKxGk1NLFmlep/e88YUWR371NzB6jYuSVn28vE/sUBkqVy4HhRgQn2VAhW8c1
	 HttcAQ4RQQ/E0h7rJFP5rLGpPuLJulu/DAlSU13V090XeNzARj3EdSmFiMtXsrqL0l
	 CGfSPifd5DhcagzM0aOt65kV/1x2eFA7BmRvrrTaV+eMFmgieWBs6DqiB7XXZ3DFrh
	 l9ePHk4hqpTKzzIPNmXKn7xyuglnzAnOgHzDwSS78avYCUrna9CGGGK/SmPQRtrAYm
	 6xqhKWCu9jh4Sz7msgtYAUcE9DmK/4IS3B2rbU63eR1WXkueG3hNsumK1AY5B5S5nd
	 z8vdNZHfMHV1w==
Date: Mon, 23 Mar 2026 13:13:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <acHJED4iAeytdC2l@slm.duckdns.org>
References: <20260319083518.94673-1-arighi@nvidia.com>
 <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
 <abxl-xw7nt1jp5qT@gpd4>
 <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>

Hello,

On Fri, Mar 20, 2026 at 09:18:20AM +0000, Kuba Piecuch wrote:
...
> The simple way to do this is to do scx_bpf_dsq_insert() at the very beginning,
> once we know which task we would like to dispatch, and cancel the pending
> dispatch via scx_bpf_dispatch_cancel() if any of the pre-dispatch checks fail
> on the BPF side. This way, the "critical section" includes BPF-side checks, and
> SCX will ignore the dispatch if there was a dequeue/enqueue racing with the
> critical section.
> 
> With this solution, we can throw an error if task_can_run_on_remote_rq() is
> false, because we know that there was no racing cpumask change (if there was,
> it would have been caught earlier, in finish_dispatch()).

Yeah, I think this makes more sense. qseq is already there to provide
protection against these events. It's just that the capturing of qseq is too
late. If insert/cancel is too ugly, we can introduce another kfunc to
capture the qseq - scx_bpf_dsq_insert_begin() or something like that - and
stash it in a per-cpu variable. That way, qseq would be cover the "current"
queued instance and the existing qseq mechanism would be able to reliably
ignore the ones that lost race to dequeue.

Thanks.

-- 
tejun
