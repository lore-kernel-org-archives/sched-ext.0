Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6001D2E719C;
	Sun,  8 Mar 2026 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772959776; cv=none; b=NefyfrFFh1CjjuXZi8xDKC2hTq6857+ThAyCxKRq4yBp9FuXzJ6HSGznqZzmwOGW2ZvkP/0y9cEQtfFz5lIFGrtrUcSrJBmfSJxQdQnUxhkkgvN6RNpsmUoZC8e91soscvdG5ilfc5U49K6pFLQddNR4CGi5koh16/49w09XqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772959776; c=relaxed/simple;
	bh=YmTMPYVDW4zPzrkpk/+nDjRWid7yYBxD27/hM+P6u3U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Zp1253qeX0USqw54RGtl1zbaKkQf3aZBxxu44tVmG3YlUz2lKXUa++4JOflVvVItbLvV2O5Hp3RjSkD97sugFseNRMaHJPSyK/Mjmy8jqrIQLUnAw7mtc4nPN2A0CuBEFICwWyBPlsFUe34TrtzzAc/2nt0jmsEt3VFTmRjw0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZM866Je; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZM866Je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44E4C116C6;
	Sun,  8 Mar 2026 08:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772959776;
	bh=YmTMPYVDW4zPzrkpk/+nDjRWid7yYBxD27/hM+P6u3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uZM866JeefCVcuVCq3Y5DrZU3rog7cd4NQyQzfe6Mwt2yP4mcppnqI5TAiNLePrl0
	 nWO7GW38DVJOlXdpr2kY89hazdW43pJaCwAZD6jcSPqpr3DXPktmbKeKGiNMM43WwX
	 niZD0tTZjq/MQzQ3qJbFhowE4tGZfiCsTqSuv8xTa5UZKoczKcHlSnRvRkePPYdpTW
	 Wr7h8Tx5EkGaOsIQz9SwatVZP+cY4RyGrpNnUC9xGMTbZK4QMtbkeUNWFjmZIphNwQ
	 r4Rx7erhnIvV2MDUKDTUWJ6XtXxKpOxISPST4tYlQczjnfMgMZBbF8nVPqHi/Iu/fB
	 L8w3FFxsJ0AJQ==
Date: Sat, 07 Mar 2026 22:49:34 -1000
Message-ID: <c6fc19977481b75281c3aac84f6d1ed1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] tools/sched_ext/include: Sync
 include files with scx repo
In-Reply-To: <20260308024519.1980564-1-tj@kernel.org>
References: <20260308024519.1980564-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Tejun Heo (6):
>   tools/sched_ext/include: Remove dead sdt_task_defs.h guard from common.h
>   tools/sched_ext/include: Sync bpf_arena_common.bpf.h with scx repo
>   tools/sched_ext/include: Add missing helpers to common.bpf.h
>   tools/sched_ext/include: Add __COMPAT_HAS_scx_bpf_select_cpu_and macro
>   tools/sched_ext/include: Add libbpf version guard for assoc_struct_ops
>   tools/sched_ext/include: Regenerate enum_defs.autogen.h

Applied 1-6 to sched_ext/for-7.1.

Thanks.

--
tejun
