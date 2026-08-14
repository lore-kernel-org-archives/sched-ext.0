Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE67332EBB;
	Fri, 14 Aug 2026 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735276; cv=none; b=dB2yYteI7O6TDWkkk4w+frWvSbUVK5jwTg85hwaIlcqy4DrdDoisidGO2zvKvsLUruop4Cyt2dRzd6MMjdprromfWWg+cyAiB9KS6UMUu9Jw4XkwBQXugL2wDhDLzt6S9ju1G4T8yxwHo4XFxem8d8D88yKwZ9l2Az6gD8Kv5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735276; c=relaxed/simple;
	bh=7ylh89FTXenjrl39PDveiFXhmXYYntcvw96PAjdoaeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=rAK7s74OHaH7a2bGZjUHiPkTCUHk1Mcb6wDmiFLPZjzjTiOVJgmyb9+I1YQrwPLqCrhObUeFwwJS4bwvdRn8j2Pz8FzWzahPQvGh911GxK3F+wxPp62WGyewgi8IJ6AT37653tPUujvagQFglIhlQqZnfgXg017Pu+kcVQT8oI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2gebE9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2gebE9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5167E1F000E9;
	Fri, 14 Aug 2026 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786735275;
	bh=UmuLwaFeo+/46bcxmI0qubazaSik6SMwZIeuwa530m4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V2gebE9R29m90DbAnxwueGQdVJffNTZIqCT1x+uizo2FT3Zu9nyy84VCUo5zZvtH2
	 2d5QLq3NdrGS0//jHHT+Z/3+8WyEKgUIiYS1xQ3Xt9mb5OLvdUedS72UOs3o6LGovc
	 oT3rV1eud+Dz3bwSlPz5YB7uQS4j25fMCHDH+1MTbNXWPgVbUaYxC9Ym/13XX99g8v
	 VZtIPHPAiSRl04RGnwnhWBSVkpVmqYHxekwV2PqAtyGO/Wt1L4rknkDjAcPmPTBtsV
	 MZFJxDGiA4tSxu7+ZY8nmSzEceAWE1k1/1uzLFRtRZIQoktYl+JeWfG52fduAjmlfy
	 VqCJFxrJnpuLg==
Date: Fri, 14 Aug 2026 09:21:14 -1000
Message-ID: <47348c3fe6ba9c3fb3eb8f366ac3f8c0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
    emil@etsalapatis.com, sched-ext@lists.linux.dev,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix exit_task leak on fork failure during enable
In-Reply-To: <20260814032623.3834952-1-fangqiurong@kylinos.cn>
References: <20260814032623.3834952-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3 with the following tags added:

    Fixes: 4269c603cc26 ("sched_ext: Enable scx_ops_init_task() separately")
    Cc: stable@vger.kernel.org # v6.12+

Thanks.

--
tejun
