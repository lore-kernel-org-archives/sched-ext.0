Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6E371899;
	Mon, 17 Aug 2026 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989214; cv=none; b=uCrOrXLsE28pMHp8xBBS9OUHa6N2YlQWFrZ1+LzLD3+rQMNrTyEBs12mgH07N4GxPKqs/Eyijfm0/nTlRPecogPOOrYligQnawlp8OEZXUerp8TujMw8mjVTnA7V/5e7SkFsNEzgqYQmwPdeF72VpD6x2hf9eGMovMPSOtzyZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989214; c=relaxed/simple;
	bh=Is2j2wghblK9QFPxNZVuRhmCR40Pohscow1rlbmEAJI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=GmSGDHB5KKy+7WijqQ6STMkK/+xEbkvVNRtU1NZ3992i8a5L87zrEzmYT47sdn7ZiB6RwheRsZMNFkpgM4QQAMbCNkDaVchYgFWqqIYi1RorIZvNCbiPGotlaVb/dJ265baT83RqIQasWKYb6L6D4NAt5wCob7ut3U5bx8iTxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxSN5Qq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxSN5Qq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180741F000E9;
	Mon, 17 Aug 2026 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786989211;
	bh=Is2j2wghblK9QFPxNZVuRhmCR40Pohscow1rlbmEAJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OxSN5Qq9D2k7dSiFvlnPsHFt2RHus/erXehAfpna+RAynE/MqSJOa6BwCO2DLsfBy
	 qV+WiyNivg0ycBJPnmHVWKTraoT5KuXJjSMNpsglaDaR7YfoJp8o/GYQ3COlfeeazd
	 5/lj/h31qjzhq2KDmeZv7Zowjp0GBA0D9uVob84dx9pc6W+uTb5YvuJncV0K2Zduy6
	 aIX8wAvvdSC33d/l1KW8EkVXqQcrda2Mm9w8+htYz7udmZgM9ZDIj6+SiIlN06qpF2
	 8WaobnNObNUBulaSfAtyuF4F8NuT7HdEInH386eKRenUsbep/d7qC4ww2OMR7/Tux1
	 Sr2immTn7WH4w==
Date: Mon, 17 Aug 2026 07:53:30 -1000
Message-ID: <9ffe41fba1d0462a27443e95c5e3e03b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, emil@etsalapatis.com,
	kernel-dev@igalia.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: allow ops.cgroup_set_bandwidth() to be
 sleepable
In-Reply-To: <20260817170941.668571-1-changwoo@igalia.com>
References: <20260817170941.668571-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Tue, Aug 18, 2026 at 02:09:41AM +0900, Changwoo Min wrote:
> +/*
> + * Capability marker for userspace. The sleepable allowance for
> + * ops.cgroup_set_bandwidth() (see bpf_scx_check_member()) is a verifier
> + * property with no other symbol a scheduler can probe, so this no-op function
> + * exists solely so its presence in the kernel's BTF can be detected. It has no
> + * callers; __used keeps it from being optimized away.
> + */
> +__used void scx_cgroup_set_bandwidth_may_sleep(void) {}

__used only prevents the compiler from dropping the function. With
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, the linker can still garbage
collect its section, so please add __retain too (cf. __bpf_kfunc).

Also, we'll likely accumulate more of these markers over time, so let's
give them a shared prefix - scx_compat_marker_ or something like that -
and collect them in one place, maybe towards the end of ext.c next to
the module init code.

Thanks.

--
tejun
