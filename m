Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD022F77F;
	Mon, 23 Jun 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701596; cv=none; b=QkdtZrZZT9Z3g8ZdpiZt4Bfcf+nAOK4qEOrLHjBnxMNoZD4fCCYwNmx2FXaqW8KLTl9PWtekWrMYFBMDELtFiRni15QXYgPjBFg4GWDGQInLIRWvyHMsyuaVkzKKFTn72r6wDppQgtiwNqULWrkK3qIcolXcqCq8pLxsZMicss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701596; c=relaxed/simple;
	bh=K0mHJOlQlG9yt7f6lU81M46kiooSYMEJTNVD2Qvh1zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyAVp1au7RnKtD0+rX/rWq8Lg/PKEvYk4WYhEr7xf8oKcgwQklOQKuQ3LatQsxUm9PhQe/q5edMd8HMHcyAwkRriMgAp/uNvqEhMan9ptxPoahw79KvD/2VfZLdnnecFaahxTPS7a4kW96uu2Cp3KwU6DPFwp5oBiOIr/wV+j4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DN7stiM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN7stiM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA533C4CEEA;
	Mon, 23 Jun 2025 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750701595;
	bh=K0mHJOlQlG9yt7f6lU81M46kiooSYMEJTNVD2Qvh1zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DN7stiM43vCCxWcthoQVOYUWGMoSnFGlUp8V3bImSr7UozuoLwGVelALc/977XUYp
	 cx++WF/vNR5m7dE34CFFSuOOiqEV67yevGYOD6eY5B9xcLOcouxKg7qzZS3hrhjEow
	 CI2B9X2/OX1Aknk7vcF0iD6WMwCvW/0btCJqYT73rEKjQmcDHk0sM1eKxW+tivyJbK
	 NvjPcTm26dqBNUGR48hwWjzOM1FgeTWiABPJ4Li2tTp4V/S4EQy/QSUcKH5Bf5z45I
	 y9ejVfG/+cvWncN+Agl9sWYOKSN1HXOEwpkL3D88axogp1WmY/1/8s51kpLqb7P5Z5
	 hcU8L35NIkZcA==
Date: Mon, 23 Jun 2025 07:59:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Henry Huang <henry.hj@antgroup.com>
Cc: changwoo@igalia.com, arighi@nvidia.com, void@manifault.com,
	=?utf-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
	"Yan Yan(cailing)" <yanyan.yan@antgroup.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v3] sched_ext: Implement SCX_OPS_TRACK_MIGRATION
Message-ID: <aFmWGi8n1ndB1K_M@slm.duckdns.org>
References: <20250623063033.76808-1-henry.hj@antgroup.com>
 <20250623063033.76808-2-henry.hj@antgroup.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623063033.76808-2-henry.hj@antgroup.com>

Hello,

On Mon, Jun 23, 2025 at 02:30:33PM +0800, Henry Huang wrote:
> For some BPF-schedulers, they should do something when
> task is doing migration, such as updating per-cpu map.
> If SCX_OPS_TRACK_MIGRATION is set, runnable/quiescent
> would be called whether task is doing migration or not.

It's rather odd to invoke runnable/quiescent on these transitions as the
runnable state isn't actually changing and the events end up triggering for
all the migration operations that SCX does internally.

In the head message (BTW, if it's just a single patch, it'd be better to
include all the context in the patch description), you said that this is
needed to udpate percpu data structures when tasks migrate. Wouldn't you be
able to do that by tracking whether the current CPU is different from the
previous one from ops.running()?

Thanks.

-- 
tejun
