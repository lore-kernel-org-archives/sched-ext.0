Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD3521CC58;
	Wed,  8 Jul 2026 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534856; cv=none; b=R3/gDKo+mnSxYUCJouCfN3WqSnEJLsV4CYnfAK7NFYOkC6D9XuMYO8p/JgbI72QCmw2vjX0aPoxCFXhZahlAXWKc9YA/8b1qJcVQUNc23h5YOFfPdD470fq34FPsA2xt0UjzaDryguzbgv4qEzm6kF1iQ2jgByZpvKGfctMnrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534856; c=relaxed/simple;
	bh=cvmz4hrqphk7KcxE6scMvQxStY1tVz3nneCeb9HEoB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqELRc66+tDTRIgmwhTl0FdttzIJ6zEgMwfDLOp52H0UDtxAB8G1HHlJFUCAD02Gmo/vGFSpHH+s0b2n1VFxluk9w1kbjeU2/VlGOlvOWTUWgmwtFax4jegCkvq+tVrmRbulKZoxiTrTROhhqYrSvuwp2fCZdKHF/3L24WFdatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH1Rugh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH1Rugh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D6F1F000E9;
	Wed,  8 Jul 2026 18:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783534855;
	bh=xqQF5csxL2bubvNMLTUkN6CATUyeRMaGUkO45vk4Qps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XH1Rugh7zd6INp3CuIv2M+2JfyqyfxGQvezLDVvr9aiLvLIQA/wa+VeLv+ghqPaJ/
	 TuI0vb1b4+Aj2gJi9VdxlvteFPkccxCU8pIKzmjxWMAF49w0pXn/sAGsFAnGTAPx/2
	 rCbwseJgjA2FCN4l0x4+U/ziEt5zDSEQCNTmCE3162Qrbik9Y6RzKkCx55ESZgRTHo
	 KNbDqryFWEnhmDsvIlFJ5dSamdV0HDuENvV3K5LP42Yd6Emf9C5zWn/ocqBD3NLysl
	 Ys1JgeeVjr1nMQhqj9Ho2gaSBo5/jdEgfi665LnZjuIB9nccDlonfD++2vBKd6Zc4C
	 /rkat9LFNQCDQ==
Date: Wed, 8 Jul 2026 08:20:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 25/36] sched_ext: Add the
 SCX_CAP_ENQ_IMMED cap
Message-ID: <ak6VBhh-2dGkux2v@slm.duckdns.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-26-tj@kernel.org>
 <ak5LXNSj0buDiPMz@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ak5LXNSj0buDiPMz@gpd4>

Hello, Andrea.

On Wed, Jul 08, 2026 at 03:06:36PM +0200, Andrea Righi wrote:
...
> I bisected it and this was to be the offending commit.
> 
> IIUC, what's happening is that qmap grants the child CPUs 2–3, but race-sched
> stressor can pin its tasks to CPU 1. Since the child has no enqueue capability
> there, the tasks repeatedly land on the reject DSQ and eventually trigger the
> RCU stall.
> 
> Maybe we need a forced fallback when a task's affinity mask has no active CPU on
> which its scheduler holds SCX_CAP_BASE?
> 
> Checking this only during sched_setaffinity() won't work because capabilities
> can be revoked after the affinity change succeeds. What do you think?

Yeah, I should have mentioned in the head message but there are still a few
missing pieces for full support. Two big ones:

- cgroup migrations don't move the tasks across schedulers as they should.

- No fallback mechanism when a sub-sched doesn't have any CPUs for some of
  its tasks.

So, after this series, things mostly work as long as tasks don't move across
cgroup boundaries and tasks in sub-scheds aren't affined to the cpus tha the
sub-sched doesn't have access to. Will update the head message.

I haven't decided on the details yet but it's most likely going to be
reserving some time slice off from the root sched to run the tasks w/o cpu
access.

Thanks.

-- 
tejun
