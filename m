Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A52BF3D7;
	Tue, 23 Dec 2025 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766462456; cv=none; b=cs6UEUnXe4w3H7s2uoLAlusHFENUn2rHB9Six1EHGWUxEboBDEW+uk5/GWCDdrqgMFI0+DDHsql9Grv1pOi971bw8LQbDifWxY4VTL82lXukE1eW8kDt/cdC3ULmXxJrxYpx+0syW3cB63ju0WregDE8t83gVE52to4PaCm12dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766462456; c=relaxed/simple;
	bh=lbrIanfzA3sXmf/XxrBzZeKGib+/+MV0kLuSpoUi28U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=R0hyb11cEHm9eedLtohLZjalDcXoNkL0DgvSlhMU0CeF2Hb5Y+Jy/V9JpqOPYOJdac7LezqzDXmyEcH5KXm8KEG1rC18P8t5IvufBLzJ2hBQaRcXu9C3v83GPx+/0G699uT/8wsYISCUwyBnc8gRahWTKhLtA6VBSA1sDJ8TsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzFDIVvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzFDIVvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A70C116B1;
	Tue, 23 Dec 2025 04:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766462456;
	bh=lbrIanfzA3sXmf/XxrBzZeKGib+/+MV0kLuSpoUi28U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lzFDIVvt+twkkOB1FurNx5brrwGrnmjxo66VnW7VXlAgLpiHBZ4LXtno1hABvFW0G
	 pDiGW9jrTcE9Yf2qgjlEz3KWOg7v4dU19VXkeqUfs0BHQuqPgQeeJKpEwR7QExZHeG
	 ZP3NG0O7VtjOQ/IsFGIbvwxL8ocy1vUy9DwivDQWtWEdyeYObvcjiXaJBQuYNVwfAw
	 e1ESSw96FS2AT3zQk9yJeg/8boCo1XBjCY3YZfMBaNqDcCqSTVfwU79sFgJVpzyxv6
	 QEH7ekq+wFqvYcbRYddQGmHjzt1to37BbPbGz13g0eNKXpUwz6rCfJmdIZpcJ9SHRs
	 I/l7u1t7DVm8Q==
Date: Mon, 22 Dec 2025 18:00:55 -1000
Message-ID: <5c5ccadb2e4c647200293b35fd5c9ebb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 emil@etsalapatis.com
Subject: Re: [PATCH] sched_ext: Use the resched_cpu() to replace
 resched_curr() in the bypass_lb_node()
In-Reply-To: <20251222115318.18997-1-qiang.zhang@linux.dev>
References: <20251222115318.18997-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19-fixes.

Thanks.
--
tejun
