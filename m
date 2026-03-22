Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10C33EAEC;
	Sun, 22 Mar 2026 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774139219; cv=none; b=AAsQvZgGfoOPkSvlHl8NNHkn4I7dWgkoLyBM/aWmEGboverqJcEKvy6aXXFgunwz1DzTuAubwwmKp1Uj0XIHHeM0QOsB0hJnGOlXpUT+AzyAg+gygFAZ5BOwERq06ZpYdutBH6W+kyFQPc+qonTW0BoMEZx0Dy3ewtfNvLmv/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774139219; c=relaxed/simple;
	bh=AbS0KTt2tdBAbPBlNYMSh9/gApKCAn3FQ14nzojGKbA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hhKTHy+iSKjC7fYiOF6nGMpL5qywrBeZxTGsnMv/Wkd4pmQaYH44v4jQaZ84WlcS960IUOfay4ofukY3hLO4MeEBIiE5j1ZP5PyabKoMsvPmK/DH9jNRDbcOlS9Cj6ABAv+Okr8qFeTDV7961NpjLeG+GM9VvNbDBH6SUUUSvgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucjlI3II; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucjlI3II"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81790C19421;
	Sun, 22 Mar 2026 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774139218;
	bh=AbS0KTt2tdBAbPBlNYMSh9/gApKCAn3FQ14nzojGKbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ucjlI3IIIrGlI1OTfSGUUKIhRKDRbIc74U3jApurS/3WKh+Ma3wz1ycT4h8YNiifD
	 /A3jk23mFfVIC3CRwLNwuYtUDHMdahVR+NIEz9cJN2YLJwwd6doyeL+1UTnxlOF7jT
	 4aV7NGjrrQzs1RUEnfIWmij/p1Ljj6kDz+VEwvk9E1nNvoqJypRmTjMLPcxiZmIPSJ
	 sxmoTq2r8kbhGDeli7F0i3FBAunP3WostA181GVf3jZEpcyOMZQCH8R3YCetX2sNrt
	 cXvxMY6B55Mq6BEjbTfABAoRRMie15h1KTB7VcpzR4ISTihnRcdakmCK32TTh9y9Rd
	 qOjbqK0Dqe72w==
Date: Sat, 21 Mar 2026 14:26:57 -1000
Message-ID: <f3c39f973a13e73bb93bcdbb26c2f8e0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Fix inconsistent NUMA node lookup
 in scx_select_cpu_dfl()
In-Reply-To: <20260321193841.905994-1-yphbchou0911@gmail.com>
References: <20260321105503.869337-1-yphbchou0911@gmail.com>
 <20260321193841.905994-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The commit message on sched_ext/for-7.0-fixes has been amended to match
v2.

Thanks.

--
tejun
