Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD52EBB8C;
	Mon, 13 Apr 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097310; cv=none; b=tm2v+ip5+fbkUqdRMYtVXYSmid1JIRpDQSJ0QBeD+lQdRZwPJN3Y60YC27hDnZbaZU5aRXBYgOMSon9QHqtEqQGuc2Px7aS0PuEKASgD6wzM4CWeg98YtyKVKl3x5K1cJNbJ5pa/uGJPA8UdUQ2aZhtbjaoBSCeLTCb+L8qbRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097310; c=relaxed/simple;
	bh=eKOn6UByKR7vto5fPGWW38hLIE5aDY9GYLs1xXdHHPQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BgDyUQIi8oPfl5W4skVHHA8hndwv11N2ZHuwvH3geI4niLSUjWF4peu86D0n5PUZUMG50lI+7iqA/DB+jc54TlRcaQhwFao9ehomxr4sHN+rdcYjGr644m+c2fZhV1e6tFBZqep3Q5l3iVB9ScsA7KSk8LM4jr2g4Y+gms0QYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+/eh/vN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+/eh/vN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7609C2BCAF;
	Mon, 13 Apr 2026 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776097309;
	bh=eKOn6UByKR7vto5fPGWW38hLIE5aDY9GYLs1xXdHHPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D+/eh/vNq/PsHOele7NPZphImv9FOIrynCIdGCuu9fYhAh6bnEjoeoydKraJUY0lX
	 H3nCAugPooaHv5VRWzrJ4BeMkd9dH2W6jX3kHmi6O0ZkjC3LKdQDijuZMnesKTjfMb
	 Lx8PuQUgjIuJgEdN9PdZVUVOa72Nq1A2K/WX0dkAhtJvoU4zitLlockJoMp/f+2DE8
	 DST6Wpge4Ci8pcNb2TBOgMABW6xrPnYJKFMcDJyL6W99a75/7ycGP9CuJ9fbGpS+74
	 OjrvvtdrmoRt1GStly/FMEPj+yXZC6hTlfA0if1PmJwV5sAahACch/4r04pph9d/7x
	 txz3vu2QbZ0yA==
Date: Mon, 13 Apr 2026 06:21:48 -1000
Message-ID: <4f5a59fc30610985e6f7139696b5e5cc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Kick home CPU for
 stranded tasks in scx_qmap
In-Reply-To: <9e172bda49dade833db7118929332693@kernel.org>
References: <9e172bda49dade833db7118929332693@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Tejun Heo (1): tools/sched_ext: Kick home CPU for stranded tasks in scx_qmap

Applied to sched_ext/for-7.1.

Thanks.
--
tejun
