Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18400356776;
	Wed, 13 May 2026 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702500; cv=none; b=TvbraJ7k7i8UV1jjJPPzNseEwHfvIQSPzIFHVjMryKOqxPXcN4PIqZ8f39uZnqBqxoSkCnmSXUWt2SM1TkuU1zwlWZR0hrxSP4peqa9w0lE2vLO4Zv4P6p7DmXxAA3B/XnzJi5+3UpMaUr0f0O0ywoAqI2xn/RXKtic9P2t8iDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702500; c=relaxed/simple;
	bh=pXyuFTjZajSeGw4jppGeltSqYlOR6+gZ21/rN3h9Pro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luM+pFMlh/l6FbveNWEKEPS3HwyZqpyE9X4WVmi1ZOJLpGrloob5QyR+TzpFevcnxQplv+nHMVw6E6JNryaTLTogvc9QVdpt58MyqgT+0jn6+onZf0IdTezOfW83g4OP4Y3TOwrAqXVAqsGIhYoccQ7CO8/vON7PnATcXidu9aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CttUnVY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CttUnVY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85742C19425;
	Wed, 13 May 2026 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778702499;
	bh=pXyuFTjZajSeGw4jppGeltSqYlOR6+gZ21/rN3h9Pro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CttUnVY+zq/UmIGAH8M8Ls1apnh531ecpO2KMAE/sBknFqbhI4NJzDrDRdXZmbBgY
	 91tuDot4+HZXoEXBDorSfprc7lvCRzVxHu3H9+V5leVNmOE45ag/D76pzf/Q/mdyvJ
	 572FJxV34O5xvYkXvNaM5So177k9XPjthRMOUv+v0tEEaFOERRZQYMoUs8noFWNOYE
	 YZ9wFNe+3mLU+ovgHR+wGYx4rzlSAR4KsStXwGxHMXC1VsW3aT7UoEc2GjpYcSDusg
	 g8YSL1G6kSBT94zj0THXndaZuy8dJPDBL0SPJZd6x6hoi+YJK+o/CXcR0wralIgMr5
	 qT1ijigqXtzYQ==
Date: Wed, 13 May 2026 10:01:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Samuele Mariotti <smariotti@disroot.org>
Cc: Andrea Righi <arighi@nvidia.com>, void@manifault.com,
	changwoo@igalia.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH] sched_ext: Fix spurious WARN on stale ops_state in
 ops_dequeue()
Message-ID: <agTYojgRwDH67QMC@slm.duckdns.org>
References: <20260513095329.4029345-1-smariotti@disroot.org>
 <agSKJbtmpRPLgYJW@gpd4>
 <agSpf9QRx4zqhZxx@cachyos>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agSpf9QRx4zqhZxx@cachyos>

Hello,

On Wed, May 13, 2026 at 06:41:26PM +0200, Samuele Mariotti wrote:
> if (!(READ_ONCE(p->scx.flags) & SCX_TASK_IN_CUSTODY) &&
>      !WARN_ON_ONCE(retries++ >= 4)) {
>          cpu_relax();
>          goto retry;
> }

Let's not do the WARN and exit. We shouldn't get this wrong and if we get
this wrong, it's going to be obvious from lockup detectors. Can you please
add a comment explaining the retry condition tho?

Thanks.

-- 
tejun
