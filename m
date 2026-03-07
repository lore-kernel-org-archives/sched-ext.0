Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA99333A029;
	Sat,  7 Mar 2026 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772897900; cv=none; b=qniFcoJHTHjXiIspH1Bv4FAFA9wo5Nox2JrMPJsIBFsVyaBpt1hYRBXAfn8VeShnzNXEjcxF63eP7J5dsCYznZ2U2Boxpd8FpDHySX0QxQMjEKkqns9z7oqcVrH7LiNM2ZAM2OCClp3DSzxKaKboyf4vk8ZinlCa/pa3p/lsV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772897900; c=relaxed/simple;
	bh=s/Cr+2Y/FUtp3tcDypalwf5p2lZA5IlNiCfdlVDWbdM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=kDzVRwCQF+Hh9lO4o9XWT6mzr5sCty3fMn8zyDSbUEAj7oxbnYTW58Zl5jq22f6zdfOvea8Xm+5JZavcGk1PASudWGHjsYt6xee/uYkalwfF2EdrwOOdMiny8EwGBY/IwD+cr/oqYZe8jPb/9+9exnGqjPxs1rH/iz0WTWbVdt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpEaTqOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpEaTqOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4CEC19422;
	Sat,  7 Mar 2026 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772897900;
	bh=s/Cr+2Y/FUtp3tcDypalwf5p2lZA5IlNiCfdlVDWbdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JpEaTqOzP+LvYrCsgumVU6+OQYFfAhfjITgL9h02cOG1BS63AJkv5N/OmQ6toxKyC
	 faByNGt/7xnFwM7E9fUUipnbkyDQs2diHla5Z3hV/ra5v6LCe7vfZsb2oxDmtCP7uV
	 AAUIc6UPRbRAQmQaW6xexiPsoZkXn+Zt75X+EtBdZTc4Cbh8NOCxXwRoJfQjc9Q/Rs
	 CvlVk/Cr4UbZieNXsiN69AnoHgz54dRi/4wa40onDaQV9dofrrExIcvGTytggUK3D2
	 ne9j972p3qqeYcfjMihld5lyT0jQBlv7TD26vJJyV1/Mzmzn7d3ZvgmNecH1K4tWVC
	 0prZBIJ9QfmrQ==
Date: Sat, 07 Mar 2026 05:38:19 -1000
Message-ID: <b6093691dff6d5fd0e25e5d40e247efc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 emil@etsalapatis.com, daniel.m.jordan@oracle.com
Subject: Re: [PATCHSET sched_ext/for-7.1] sched_ext: Overhaul DSQ
 reenqueue infrastructure
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Tejun (15):
>  sched_ext: Relocate scx_bpf_task_cgroup() and its BTF_ID to the end of kfunc section
>  sched_ext: Wrap global DSQs in per-node structure
>  sched_ext: Factor out pnode allocation and deallocation into helpers
>  sched_ext: Change find_global_dsq() to take CPU number instead of task
>  sched_ext: Relocate run_deferred() and its callees
>  sched_ext: Convert deferred_reenq_locals from llist to regular list
>  sched_ext: Wrap deferred_reenq_local_node into a struct
>  sched_ext: Introduce scx_bpf_dsq_reenq() for remote local DSQ reenqueue
>  sched_ext: Add reenq_flags plumbing to scx_bpf_dsq_reenq()
>  sched_ext: Add per-CPU data to DSQs
>  sched_ext: Factor out nldsq_cursor_next_task() and nldsq_cursor_lost_task()
>  sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs
>  sched_ext: Optimize schedule_dsq_reenq() with lockless fast path
>  sched_ext: Simplify task state handling
>  sched_ext: Add SCX_TASK_REENQ_REASON flags

Applied 1-15 to sched_ext/for-7.1.

Thanks.

--
tejun
