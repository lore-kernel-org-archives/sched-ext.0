Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4448A2A9;
	Tue,  7 Jul 2026 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463796; cv=none; b=HGc2+l8zjlFyufNmDeZePaG7NAAIoF8tPt6QqV2A1Dk2Hxaw9VMtUsxXA67wKE3eUIL8ClqaPIg0whlDPMQpIzQgdOry5cvXdisXofPLa5DT6utgB1nlXxg4TQ3x1camErb3Ic6rtkHWeZci8zKzDw2U+DrhT/g5PQsQJiesM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463796; c=relaxed/simple;
	bh=VtHs/UTAGG0YSVnmuw2wH2di7JW0qrnBk0CiMNFYQ/M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=peETGGsbZkx5/2/z77g9lpSgRcO71fYjdMoVVt1YxRi0J1u5PB/mbwVsN1YOnJTXwo7g7960TWx9H7zM0A54d0rWu5pB1gcL9rCyrnbXiu80O38nDH/Hi2+/RuQApePLiyI8G7yer+mDx+THJbSgFWIqqfhHO+JnwojiN3LUKSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoqmzK/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoqmzK/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069841F000E9;
	Tue,  7 Jul 2026 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783463795;
	bh=nNxtMYtueCr0TEFVx2kbpPOav2El+CzerpeN6il2QbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AoqmzK/v77MOlmSjpuxhaVxpc4fHpGEgimcHG69swK/qb/0IsVo2R4xDmgqaEmV/v
	 nBTw3+FjzHJzj2UZ5hHSQ8vF45+kslYG3qnStDZdav2SUb8tg5z4GHKCtF+YRW1vzG
	 oM3BjXOsER5k8TqJEhK3DN5kJo7PFS1Mt31+vlvOG/ifBH6U/ynx0vYg9bFHTB18RG
	 6mxn/ZIKldCP0w48Byv2lUtIEqkahXRZIPSWfOitdW+yggaU9sz7f97hGCmQOXsvW1
	 2uNpJHKPj9zjdluWz0KH45VCvOL12PYWeAjYkgr2kNY7G2je7S3QKSw84g/f8F7Mm8
	 LekvRGFgJUcuw==
Date: Tue, 07 Jul 2026 12:36:34 -1000
Message-ID: <455e701bca66bdecde530d225f4dba0a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.2-fixes] sched_ext: Preserve rq tracking across local DSQ dispatch
In-Reply-To: <20260707173851.153379-1-arighi@nvidia.com>
References: <20260707173851.153379-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

Instead of clearing and restoring the tracking at the function boundaries,
can you wrap the lock switch itself so scx_locked_rq() follows it? Something
like:

	static void switch_rq_lock(struct rq *from, struct rq *to)
	{
		bool tracked = scx_locked_rq() == from;

		if (tracked)
			update_locked_rq(NULL);
		raw_spin_rq_unlock(from);
		raw_spin_rq_lock(to);
		if (tracked)
			update_locked_rq(to);
	}

Then use it at the unlock/lock pairs in dispatch_to_local_dsq(),
move_remote_task_to_local_dsq(), and scx_dsq_move() (the in_balance ones;
the !in_balance fresh lock stays). That keeps scx_locked_rq() naming the
actually-held rq the whole time instead of going NULL across the dance, and
drops the tracked_rq bookkeeping, the WARN_ON_ONCE()s, and the
in_balance-vs-scx_locked_rq() coupling.

The == from guard makes it a no-op for the consume path (there it's this_rq,
not the rq being released), so that stays as-is for now - it's harmless
today because the deactivate runs under the migration guards. Would be nice
to bring consume under the same helper on for-7.3 so the tracking is
faithful everywhere.

Thanks.

--
tejun
