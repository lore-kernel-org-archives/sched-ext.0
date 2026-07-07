Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230417D6
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384295; cv=none; b=KEB4hB15v1eN8Ad/Ncbs6cTl0mvzuKmh0JkqBPJ7EAjW+ptpAV3xW+MAdL6mxdzzG4OdUaxUEAhK7Sx8Ad0kMJppGOycaB3+JfQYKijRpPhk9Kx9BGrXwHeCliXVtDvWfCJeBH6shYkwbnIzw6xqVPpzrCRdFxOVqDEQgxYqn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384295; c=relaxed/simple;
	bh=L716oNi0RsjS3hb1ThhDBfocHtnErPXB/6t6h0cK4zM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M1Ry9lpv1HHPtROznK9XkX4d6+kEhOwaOZdSQ5LmoXJB5IlAYVn254y/Y0U7cDiRwAj+OEe5i3Mb3AwKpxlS12xlx779bhQ5EZ8WZAY86dNtI7ZtPSwipkD97GSpxB7PqhNyIQBXUs1oE58Fjze6IIxA2K6sYQ+DDNu+CLbrpjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlQbFPsn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlQbFPsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81DA1F000E9;
	Tue,  7 Jul 2026 00:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384294;
	bh=z2W11Z2O/3nH2L8yvRduvM8IyDwo+z5cZ14WFdichMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dlQbFPsnVcaRcVZvFPT4ScYyHt4P7fXhRwqYOxl/hZp9LXUwWJDQJQ4YWZwCNJQxD
	 fhj0t19aefWKt0/ImjuLN9pWMhS4SztPNH/vuEHm5aDaoKia60LoM8zqhQftEBPXZT
	 bhwU6JNBdpo31QbHWi1eQ3JnYCNMW8SG+RlHevLjckAuXWqNmkyc/nqAJoFeza6b9+
	 THpcajyauRcYxJ4gzYlnd1EczyceeFEIOzjm6E7tPlsTWULt2bhELOADL2yJTwfvZe
	 vFrmZSjLPMboAcouN95ttrUxfP+DCv66gMhGNpennWZHawLZgALZd7fwDhkTNe7+qC
	 bMA/eSbEdHHUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 13/36] sched_ext: Defer scx_sched
 kobj sysfs add into the enable workfns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-14-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-14-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:31:34 +0000
Message-Id: <20260707003134.A81DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving sysfs addition into the new `scx_sched_sysfs_add()` helper =
introduces a new silent failure path in `scx_sub_enable_workfn()` that leav=
es the sub-scheduler in a half-initialized zombie state.
--

--- Patch [13]: [PATCH v3 sched_ext/for-7.3 13/36] sched_ext: Defer scx_sch=
ed kobj sysfs add into the enable workfns ---
commit 507940b158b167ff0f8a1c4f5cea84a731673de7
Author: Tejun Heo <tj@kernel.org>

sched_ext: Defer scx_sched kobj sysfs add into the enable workfns

This commit splits the sysfs kobject addition from the scheduler
initialization. It introduces a new scx_sched_sysfs_add() helper that is
called from the enable work functions once the scheduler's sysfs-visible
state is initialized.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 0504204272732..e94a415ee10a7 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -363,6 +365,10 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  	if (ret)
>  		goto err_disable;
> =20
> +	ret =3D scx_sched_sysfs_add(sch);
> +	if (ret)
> +		goto err_disable;

[Severity: High]
If scx_sched_sysfs_add() fails (for example, due to ENOMEM in
kset_create_and_add()), does this jump to err_disable leave the
sub-scheduler in a zombie state?

Since scx_error() is not called before jumping here, the scheduler's
exit_kind remains SCX_EXIT_NONE, which means the disable work is never
queued. The scx_flush_disable_work() call in the error path will return
immediately, and the function will set cmd->ret =3D 0, falsely signaling
success to userspace.

This could leave the sub-scheduler partially initialized but fully linked
in scx_sched_hash and parent->children. If the parent scheduler then
dispatches tasks to it, or if it is disabled by userspace, could this
crash the kernel due to uninitialized structures?

> +
>  	if (sch->level >=3D SCX_SUB_MAX_DEPTH) {
>  		scx_error(sch, "max nesting depth %d violated",
>  			  SCX_SUB_MAX_DEPTH);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D13
