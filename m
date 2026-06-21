Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531FB640
	for <sched-ext@lists.linux.dev>; Sun, 21 Jun 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782059997; cv=none; b=BmaeOOh9zWdfsnk4ZDdZ/8DyhlObm8/uqPbIpKhhhRqVUSGwFrXR/myTY3rEY7p5iehB8YzvXEfVDrUPa4U7pK8rirg3sEO/y/D+01MYalX40LT2oPaYjsgzEUfOIhGthmcWr6Vuva1UTkfNRDgcePdqduAQDoQHmq5rpVxqPoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782059997; c=relaxed/simple;
	bh=GqBqwYlVg20JVo6f/9XUr8laXPjHNMVyCE3lSPi6Dl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qaJ+j017R/I8BphPtHQnRqOEZQ8s3U12RFIL0FcXG1zmgyzXt9dP9SQxYM35Wog3Dffmmmnb71jVE+WU3Ts0js8bYD7kL508zsY/wP1uRRwnusGuOautDnkodXIilXeLa2vNIqg3F55k9fwXSd/NpBQ6mlXTUo52/Fm0WMYsTow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STbQxdBy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STbQxdBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E9D1F000E9;
	Sun, 21 Jun 2026 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782059995;
	bh=dhE9rwLzEZ57AKiT7Ng/s5u08EIh/oM4ZVeXpQw3Saw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=STbQxdByJPDCrndrPydw6OkS4FVg88Ell+5ik/yxivheB24y3Oz+EKk5m7avWS6Or
	 ymkIthKU34s7SLB2F1/H3lGtJ7Fwjn3y5wc20ByKksb0oQw1h5OoUFU8yd39TV4aUF
	 8PHG82I+ujJ9nDHNmfP41j+6f+wjn+gNmMVJlXAPjLPwe3H8cfwPyL7N+o9JRhcGax
	 MnvhHvBgfuglzL0YPHJXHLl/q+5ZJ5WnDotixTiigZEPpN48qnnHm5qAma/3QnZoWm
	 E+famTkjp5uIszynX+6iBi0AUzgVhTy14HejbDV03iw7A6pTv+JHB2SIVU5o6SU3Mw
	 EDtfA7nJbKesQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Move sources under
 kernel/sched/ext/
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260621163026.434856-1-tj@kernel.org>
References: <20260621163026.434856-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 16:39:55 +0000
Message-Id: <20260621163955.80E9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Stale file name references to the renamed file `ext_cid.c` were lef=
t in comments.
--

commit 14b1d7b00c99cf24d69bf37c03dd5f2f1c7a83d3
Author: Tejun Heo <tj@kernel.org>

sched_ext: Move sources under kernel/sched/ext/

The sched_ext sources had grown to ten ext* files directly under
kernel/sched/. Move them into a new kernel/sched/ext/ subdirectory and drop
the now-redundant ext_ prefix. ext.c/h keep their names.

> diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext/cid.c
> similarity index 99%
> rename from kernel/sched/ext_cid.c
> rename to kernel/sched/ext/cid.c
> index 66944a7ef79d1..aeaea88f34c55 100644
> --- a/kernel/sched/ext_cid.c
> +++ b/kernel/sched/ext/cid.c
> @@ -71,7 +71,7 @@ static s32 scx_cid_arrays_alloc(void)
>   * scx_cid_init - build the cid mapping
>   * @sch: the scx_sched being initialized; used as the scx_error() target
>   *
> - * See "Topological CPU IDs" in ext_cid.h for the model. Walk online cpu=
s by
> + * See "Topological CPU IDs" in cid.h for the model. Walk online cpus by
>   * intersection at each level (parent_scratch & this_level_mask), which =
keeps

[Severity: Low]
Were some stale file name references to ext_cid.c missed in the comments?

While this hunk updates the reference from ext_cid.h to cid.h, the block
comment in kernel/sched/ext/cid.h still references ext_cid.c:

kernel/sched/ext/cid.h:
 * possible-but-not-online cpus and carries all-(-1) topo info (see
 * scx_cid_topo); callers detect it via the -1 sentinels.
 *
 * See the comment above the table definitions in ext_cid.c for the
 * memory-ordering and visibility contract.

And the kernel-doc comment for scx_call_op_set_cpumask() also still
references it:

kernel/sched/ext/ext.c:scx_call_op_set_cpumask() {
 * @cpumask: new cpumask
 *
 * For cid-form schedulers, translate @cpumask to a cmask via the per-cpu
 * scratch in ext_cid.c and dispatch through the ops_cid union view. Caller
 * must hold @rq's rq lock so this_cpu_ptr is stable across the call.
 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621163026.4348=
56-1-tj@kernel.org?part=3D1
