Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2754A92C1;
	Tue,  6 Oct 2026 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315076; cv=none; b=AkFnEHfVw783dzJmZYQhEFc+XzzLSOIza0Bw+42yXWB8PjIdq1FktS2Gk5vMasvt4qE/kLHtp84vJA8Jx9dlpkUU/B84VxgAozvic7LVU03ARoNQkLR4Ug0HcEzF2VMhTXG1Bv7KzWfKhpXfMr8ollxCFDNQMS5r6EFCy/CT43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315076; c=relaxed/simple;
	bh=VB14mHz/U95aRk8onTVOYRcgkLqtnfm67lyRK26x3Lg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=DR3UMBaO5cOT4Q+HaRcNUBjgvJtmz7XlAhIAkLikAiKdp8+e/6n/1BlhdAMtBNKsi9EMKqMuUKeBYUDufVEcTldFPaV0BbsqiqF3AbzyZ3ncQTbqH3PUbOvyMRXlT6Hc8qXjxtoTLvGtskDIxK0NrE7ZtwV7ScpbFo9xuczX38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoetL7mP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoetL7mP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F1D1F0089B;
	Tue,  6 Oct 2026 19:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791315074;
	bh=VB14mHz/U95aRk8onTVOYRcgkLqtnfm67lyRK26x3Lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VoetL7mPvlledfWVADAAXgd9HrY9XZt+6EE6zAviFtjbN/6FVNpOO+yoTvx5/iEH8
	 hUNBAKrJqPxYCljYTh0VZjXN7x+4NPci1U0E+TusgThoLNZhyhKnAEW0bGb2I3Ke0o
	 8fyiphrAvtm83GZVYGB0ew0G2yAJsj+wUkQ+yO9GIqvViPa0e4LqdnO+wC/00YmfjR
	 Uo6cjauArf5opYjIOEP1HX/WOFzkuZU+Nibecn8MAXP4pT48lOOxda/Yo94CO90IxR
	 7JnGbectkrr3ECor0rzoqMMlbkS3BmSuMdU4mgI6e2qJWOETAkmDPpe9C6plL9JDXc
	 o+fPOEeQkKl5g==
Date: Tue, 06 Oct 2026 09:31:13 -1000
Message-ID: <4bc0c5e88d602dcbc886b1214c676c8d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: Tao Cui <cuitao@kylinos.cn>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2] sched_ext: Reset cpuperf_target when a sub loses
 SCX_CAP_PERF or dies
In-Reply-To: <20261006142834.2815197-1-cui.tao@linux.dev>
References: <20261006142834.2815197-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Tao.

On Tue, Oct 06, 2026 at 10:28:34PM +0800, Tao Cui wrote:
> Fix it by restoring the neutral base that the root scheduler establishes
> at enable time, at every point where a writer loses the ability to
> write:

I don't think the kernel should be picking a value here. The cpuperf target
is last-writer-wins state with no owner tracking, and the only value the
kernel ever imposes is the initialization at enable. If a parent grants
SCX_CAP_PERF to a child, it should expect the child to have changed the
targets, and restoring them after a revoke or in ops.sub_detach() is the
parent's responsibility. The root holds every cap and a sub-sched parent
holds PERF wherever it could grant it, so the rewrite always has the cap.

There is a gap on the kernel side which makes that unreliable right now.
ops.sub_detach() runs before the child's ops.exit() and before the child
loses kfunc access, so a child timer or its ops.exit() can still write
after the parent has cleaned up. I'll post a patch which drops the dying
child's caps before ops.sub_detach() so that the child is inert by the time
the parent is notified.

Thanks.

--
tejun
