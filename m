Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C92397942;
	Wed,  9 Sep 2026 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977209; cv=none; b=GH6KgsyHjD3kJd9u60A57puE9hXe9WqisM8zryebTF2kIsZ+Ytq9jQbs4sImxarrjaf/nET05/+Sa+0fTyNk49g2vkW4blMMFKw3CoQN4AObCI/14HVeJI5OYPXgygsWDATLQjrAGUYHb6f8AhUjzv0hUgcm7yZYKwsKkOKMq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977209; c=relaxed/simple;
	bh=WhHwf3Ka9Vf1q1walvuzaPCFqfmh1Pk/QqL+ux/sqS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gO1AANkuTaOJS/kjXTi1uXGCfpZXwHNRn3ao35ZyQMmJWiI2261c8QnbPIqG9Oc/NWxFzQzofELyexfo8tDvKINrXIG2/CWU4XneIwngSijJlNZqCxJhfH4gFzHtIVmpPX7rAUKwWn6GaZ4Y/cdhAeiC/RqvIzEczVkJmF5qiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwqIdlmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwqIdlmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0317C1F00893;
	Wed,  9 Sep 2026 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788977208;
	bh=LvHxWR4ioQbnIzdZ8OczcxC6IlozkFwifw0VvgYRDwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jwqIdlmDP3rSFe/RUaTHUt21F06S2D0PBSUqpIYvR7ADE+2x/p+tbISpbg39VmN+w
	 iT5yY6iXlKBvgOFgL9Sd6nlLlBm3RktHG7oRJXZCTHL2IBrMxLsd/0ZLZI/x6acZLJ
	 iteGhNHIarOCnZwAFIQ1SYECAeFZONOjq/D0obAHwBk3kU8/ZnRxU/CFng37Q1lxcK
	 +QpLYr6G0AaPkcUa6uQpzfkXywyKnjzrkTY4tg5lJljdmlzOQicO+6UApvipjE0IUJ
	 NSdWxj41bU5RyB6ThVhJ5D5qsJ0aouYR7DngdJNHvcdAH1+ZfkWIenYe0+Y6zryBMc
	 NY0NN/LGA7YFw==
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com,
 Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4] selftests/sched_ext: Drop -rdynamic
 and stop clobbering LDFLAGS
Date: Wed, 09 Sep 2026 17:52:35 +0000
Message-ID: <178897635521.2.18013318571965009488@kernel.org>
In-Reply-To: <20260909151741.24742-1-yphbchou0911@gmail.com>
References: <20260909151741.24742-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello,

Applied to sched_ext/for-7.4.

Thanks.

-- 
tejun
