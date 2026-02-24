Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF528F50F
	for <sched-ext@lists.linux.dev>; Tue, 24 Feb 2026 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955819; cv=none; b=i5f69X+N7F3wK2qx0TTlaCYENrhSCRZeBp/fYggS8gonFFePlfhhR3/Kp2sOrqkoMgilNcXXveayJJ294JW0/A+gHvIASrQ/kpXU4H5Bfu85YMPWboxaCxRtAbTVlPYLYZlxplILJJFMi4l93aQmXpeLSGdLgiwLr/dDsmO0Wc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955819; c=relaxed/simple;
	bh=qiSuXuA/tlOkci/p/xzwT3LAlz602u+XCITj+4vo09Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=eg+MYvusvpFGQPDeOG1b0P8zxObBURcqi5pYLSXHozNB9ZDIqmpg2kJpjnd5nNz9CtqAxyfQjj6b86cHGAzpLxiUSiNr8oTcL4uZU0Gw7oz/kVTg7/0n33zPdtkzboZnTsZ4DsNcNbJtE1ZDQdavz012iMiLJGct1z4FMmawWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an/QmEXF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an/QmEXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA57C116D0;
	Tue, 24 Feb 2026 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771955819;
	bh=qiSuXuA/tlOkci/p/xzwT3LAlz602u+XCITj+4vo09Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=an/QmEXFcJWqDuYBgksJI1rud46S2HiC6XPHhvKrZmng9dP+icYOAgrp+dN+ho1uh
	 7NvsNcfcfiKNZbZrgGCKjPCQI6Wa5DzDc8vMRhlrXFuvGA71YRSRkDpCSnRNCjmj6/
	 uTZp9FtKhs/FYYNuV3xYGI7dAIpWhcSe6J9a7J1aK0Sir9UybAkpsUIIpNH/U3/5kc
	 S0ukjbpU2kY18Qomi5TnIxJ3ulDzHc8XRgbyyA+0a1Jxd+QW561YMITuPa0YBDbiWv
	 xLrbjL8rK9ABehkwOcCFjSWFIkUVyR7kYbbGLdQVqEa0lyUqDadqS3u8tDP9q5QuQf
	 sTeqFix1pPClA==
Date: Tue, 24 Feb 2026 07:56:56 -1000
Message-ID: <70df9b323597ec4c3ccb7fad2262def0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, jserv@ccns.ncku.edu.tw,
 emil@etsalapatis.com
Subject: Re: [PATCH v2 0/2] tools/sched_ext: Sync configuration with upstream
In-Reply-To: <20260217072600.953197-1-yphbchou0911@gmail.com>
References: <20260217072600.953197-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Cheng-Yang Chou (2):
>   tools/sched_ext: Sync README.md Kconfig with upstream scx
>   tools/sched_ext: Add Kconfig to sync with upstream

Applied 1-2 to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
