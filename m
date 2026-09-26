Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D97351C22;
	Sat, 26 Sep 2026 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465259; cv=none; b=QHLHI0jIrodVOkdLdKZFI/I6SJeoL8XUYgloCdPS79ZANYbcbbcUG6/zs41Sx0kB3mSAi+6Aph6Q+a4EETPs1PeiIbZdgOdFrHff6if6XgGoa1qoO2wzJXU9kIOgP8crUtuDUk2hIxyoa0FX2S7+/AplkmVoHsRDjEv/2aSQTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465259; c=relaxed/simple;
	bh=zFiMNwt98oTpvMBil5p5wy11Di6vsQaPP0yvHqhiKf8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=LSpprdelYkyGNCY97p9bdCORCyKxTol39N2sB4KPvtUic7VvBKVzcfdLYIqtNToTamtYRem6HYH7B1H6OvPUA/s6m1n+CiROwiUZRbINr59Xb1RvKyRNcUotoDXUnJUQCv19OP5h5H7iGxiooviv5OCLzve+I33ADlLahKwSHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfIkQOXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfIkQOXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64C61F000FF;
	Sat, 26 Sep 2026 23:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790465258;
	bh=vwTaqMn5vzKXCc+vGX76agyqURdQRCGyBnTEVwedDBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CfIkQOXpRx6DO0hbWSLLiQAh86eNG+TE6nde0M/6S8JC8o3Hp6rEpvvMYY6f6XqH8
	 hGL6aInTBkFazvcgmaaJf891C4lnOM009gzt8UzQoJ/nWDwft2JunggjNtute6rehr
	 q7M/eHEPl+E08ZbfXJcMl6MIJoDZf9tnWyuJObhSayfzkTi6/skAA962znXX6H9xTt
	 F10j6HUCEtd7+rIcUE5DvJYXYykgUP/D+XBuqGUAsosY2HeoThLbtGfKg0/B3rbfkn
	 8mL9NS9Ot5wNmOqFYIFa9l2t0ioEG7fVwO/0ljRgAMCa/3qnUsBOm4sMbHqD0zwEl6
	 7deA4nxmrUYXA==
Date: Sat, 26 Sep 2026 13:27:37 -1000
Message-ID: <134cbadbf6412d22d6bf34686f7cb422@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4] sched_ext: cid: Represent clusters
 explicitly
In-Reply-To: <20260926212017.3351797-1-arighi@nvidia.com>
References: <20260926212017.3351797-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

The following is a Claude-generated review.

On Sat, Sep 26, 2026 at 11:20:17PM +0200, Andrea Righi wrote:
> +	if (cpumask_subset(cluster, topology_sibling_cpumask(cpu)))
> +		return NULL;
> +	if (cpumask_subset(llc_cpus, cluster))
> +		return NULL;

The second drop inverts the hardware on a part whose cores all share one
L2, such as a single E-core module or a DSU whose L2 is the LLC: each core
becomes its own cluster and a scheduler looking for L2 sharers through
cluster_cid finds none. The sched domain doesn't drop the cluster there
either, it drops MC and keeps CLS. Can we make the level inclusive instead
and skip the conditions altogether?

	cpumask_or(cluster_scratch, topology_cluster_cpumask(xcpu),
		   topology_sibling_cpumask(xcpu));
	cpumask_and(cluster_scratch, cluster_scratch, llc_scratch);

Private-L2 cores yield the core, modules yield the module and an LLC-wide
L2 yields one cluster per LLC, with the walk order unchanged. That also
drops the helper with its NULL and empty checks, which no arch can
produce, and the lines past 94 columns.

> +			s32 cluster_cid = next_cid, cluster_idx = next_cluster_idx;

cluster_scratch is always empty when an LLC starts, so the refill block
assigns both before any use. Plain declarations, and the per-LLC
cpumask_clear() is redundant for the same reason.

A few smaller things:

- The comments in cid.c and types.h describe SD_CLUSTER and when the sched
  domain drops the level. This layer's contract is enough: the
  cache-sharing level between the core and the LLC, and a core without one
  is its own cluster. The sched domain also doesn't exist with
  CONFIG_SCHED_CLUSTER=n while the L2 masks do.
- scx_bpf_cid_override()'s kerneldoc still says core/LLC/node is cleared.
- The test paragraph can be one sentence, and the Based on note under the
  separator is moot now that the fix is in for-7.4. Maybe "sched_ext: Add
  the cluster level to the cid topology" for the subject; nothing in the
  tree uses a cid: prefix.

Thanks.

-- 
tejun
