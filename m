Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F520E030;
	Sun, 19 Apr 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614676; cv=none; b=CcaYLz+y46hzJXyaEYaA32qsg4gLXjKYa/6bJfZC2oJ6fDO3THQH9n1MDtsHNwBNO2J/D1YGiwH4fQbxp7xZgJaWaqQdfO+oWuoKJ4jcwoj3EsAtECwT2GHyyxKDYnDsV5U/uNyrAKfdIffOWJr+PGVVewLvnv4/5I0uCKHiDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614676; c=relaxed/simple;
	bh=AYl1wHETtf0DVakcT6whBoFXge6syZnAHfYYlT3Zbw0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cnwnVYcrK1nBb11BQ+oDH9D77496l5AmTBbn9nCAJCByjmdc2MVIOgNBgFFcLp7ChjowbeZhELKASarCPj+GhAk3XGFPWQA7NNW8rwIj1/8Dj5/eDcgaDGBrOhRTNmsdvJoaAGYvKyDbRoOj/LoQ5UfcpvONsL+2qIq9QKxU8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSAfe1nF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSAfe1nF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6F8C2BCAF;
	Sun, 19 Apr 2026 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776614675;
	bh=AYl1wHETtf0DVakcT6whBoFXge6syZnAHfYYlT3Zbw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DSAfe1nFsbIflOTlg16vNR8N1bcqP4S3/MMrBeB2TGmY1u1cF2Pkf+z6dJJFJwB3W
	 TsvniTeqd5B6mHvSo1t1FuBrUFm9Kwb3MLb0gEe7/iYOjy/m5c+7IUsQnuvWJWiL0v
	 3hsSope4ZoAwB0JKuumbs4amgeBQusGGs220oyohNiPElQT0Qvz8XRKHNukk6ZjC+E
	 hMOi3PxCEPFcMJbixfIQhBpr5TzH3ePAzU9m3T4gD00BsEeomeraOAicM8AzX8I5BK
	 F9Rx8IeHU4TtkFMz8juw7z237Ckb060Mn6yBpnUBn+jzPy6c8RxtYDzk7FZDxmdOLN
	 3G8wVKqcYe0jQ==
Date: Sun, 19 Apr 2026 06:04:34 -1000
Message-ID: <d74d5225acada39582429be8da2ff0cf@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] tools/sched_ext: Add missing -d
 option in scx_flatcg
In-Reply-To: <20260418092247.1541377-1-yphbchou0911@gmail.com>
References: <20260418092247.1541377-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

-d is dead code - it just sets dump_cgrps which is only echoed in the
status-line printf, nothing actually dumps the cgroup hierarchy. The
right thing to do is remove the whole thing - the 'd' in getopt(), case
'd':, the dump_cgrps variable and its printf - rather than document dead
code as a feature.

Want to spin a removal patch?

Thanks.

-- 
tejun
