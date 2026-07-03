Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95946382292
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075774; cv=none; b=GV2aeHjUmpILb1RlkAqCUO5aHqQ/4ByQCzNzZ53bZzfiuiIz5RVaiJHVNylLqYgFfentKkEpKyDoiCMUUIk4M787ZO/GjwiJR+bn5J4IacvID5BD7zo4La56bLn0tvm3PAVjkmxpTnSqfJNbtJyyoM5ZFQRHHxkqFGarUrPzw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075774; c=relaxed/simple;
	bh=WxmWx2qX01FD+TRZg4Is2FSh5HLang9W/Z4Y3CguVUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vDquywpGqL3o8xkp9FL5J/IqHXxjY19iuHwRzYOz8cqz+H8PEwvJLnyF1VbvLxUbRvjIZ8asl4qhCFlnemdj7H7ToGp5AaVwt66zfbHQB+ZPIgbQglKkEfWwPt6RQg1YzYF/hcci5mTq54WcTV0gZAW1LTdYOSzhfKAOmrXd6i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL3epOz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL3epOz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0151D1F000E9;
	Fri,  3 Jul 2026 10:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783075773;
	bh=rpq9Jk5WONIJYhAyRLen4trFdWO02oEBy9JMNnOn6EQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BL3epOz60j6C3k4C4UIfaDfZdQnrMtcAAsygNUBOBW9WjbpERSIrtcUQ9Zg5JUOzF
	 /0nWfVQ9cJt+7Hzbj0j/LvB0OsW7k9XCwGCzWGeYb87oQM59R561qqTs9mxaw3M3CQ
	 pdVaP7f6oifpRZ6qfgfydc8tUOXFj1KzB1DfpLZ29HOxnTP9Jjo4soIVaZ2jb8dTH/
	 HsUu7b1HNG+NrLMUj5ROSabySvzcKoNlyHBgeO7vvBZ2C83Ph00/uxrwZ3YI7bbnVr
	 yRRz6ncuGwO4GQQiUZNs0w7HahmwM/WsN1qtJKkN5oYQdsj3yTaVUpDHgpsZKNfTY8
	 dqLbhtHlY1D5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 14/32] sched_ext: RCU-protect the
 sub-sched tree's children/sibling lists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-15-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-15-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 10:49:32 +0000
Message-Id: <20260703104933.0151D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] RCU-001: Remove Before Reclaim Ordering violation during scheduler=
 teardown
- [Medium] RCU publication order violation in scx_link_sched()
--

commit 2105b47ea9f8a129fabfbb3668aa7498dfc13622
Author: Tejun Heo <tj@kernel.org>

sched_ext: RCU-protect the sub-sched tree's children/sibling lists

Future kfuncs need to walk descendants without scx_sched_lock. Make the
walker RCU-safe so that they can. A sub-sched's fields are initialized
before it is linked, so a walk that observes a linked node also observes its
setup.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index c0a3a1ead2833..1e38aaad43323 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -5492,7 +5493,10 @@ s32 scx_link_sched(struct scx_sched *sch)
>  				break;
>  			}
> =20
> -			list_add_tail(&sch->sibling, &parent->children);
> +			list_add_tail_rcu(&sch->sibling, &parent->children);
> +
> +			/* inherit the ancestor bypass state */
> +			WRITE_ONCE(sch->bypass_depth, READ_ONCE(parent->bypass_depth));

[Severity: Medium]
Since the list is now RCU-protected and can be traversed locklessly, does
initializing sch->bypass_depth after list_add_tail_rcu() allow a concurrent
RCU reader (like scx_for_each_descendant_pre()) to observe the new node with
uninitialized or stale bypass state?

Should the payload be initialized before it is published to the list?

>  		}
>  #endif	/* CONFIG_EXT_SUB_SCHED */
> =20
> @@ -5519,7 +5523,7 @@ void scx_unlink_sched(struct scx_sched *sch)
>  		if (scx_parent(sch)) {
>  			rhashtable_remove_fast(&scx_sched_hash, &sch->hash_node,
>  					       scx_sched_hash_params);
> -			list_del_init(&sch->sibling);
> +			list_del_rcu(&sch->sibling);

[Severity: High]
With these lists now being traversed under RCU, do the teardown paths prope=
rly
unlink the scheduler before waiting for grace periods?

Looking at scx_root_disable() and scx_sub_disable(), it appears
synchronize_rcu() (or its expedited variant) is called before
scx_unlink_sched().

Because the scheduler is still in the RCU-protected tree during the grace
period, could new RCU readers discover the scheduler after the grace period
finishes, and access it while its resources are being destroyed?

Should the node be unlinked before calling synchronize_rcu() to prevent new
readers from finding it?

>  		}
>  #endif	/* CONFIG_EXT_SUB_SCHED */
>  		list_del_rcu(&sch->all);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D14
