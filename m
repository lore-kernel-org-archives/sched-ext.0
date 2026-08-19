Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7AA1DF736;
	Wed, 19 Aug 2026 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170120; cv=none; b=SRbY7kulzataHfsXepzAHcdXnTp9zF5yJ6dScVYrCNKX0J3JJLwSYTPduDzPNwAKI6pT/bJkklzNix8YkVHAeMQ84BjD4qui3Kn1/qEVIywLtpP91u735/43mfKTXTbbY1Iwwlg7xKjRY2MhViQqiSvVUs4wTurpbAw1tesVNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170120; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=OaPs3xoZwocvrPi4Vqc5E71Az2IvocZ9qaT+AI8wE4OhJyEjg/lwY82p+zBiL/3yz8SlhPtuT9+bJ8PdloNo7a6LxaqdBbWFm/5aaKOlJJAFmQY2PT684A61lIGVq0rIGwgm3rbdYW8aOuwoXjvXAZ6Mb0aOtxjLYCHN4v3xCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFiACREy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFiACREy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBB91F000E9;
	Wed, 19 Aug 2026 20:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170118;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AFiACREyh5eQPnQS3RD47Lg4jIBqoYWewbvwUJQXqDnl6JPtXrREbo/HIXPdNvQhv
	 yk4rK3ZgdUMmMfg26MeAuKQhXmR0+ZZ4IxtnEU6bd1zbjoP7RQ5mqdZyNdVTbAtmXl
	 /QBMjONrCaTtQmASMxA/4r22tj2GQOSR6ZDyQMYXeTt3xlf6ajoCSVN7vLNJ+YPCrS
	 Tl8aOyn+8yOtVL1Zyv2lYz2fndPJwiS612/ejmJNNYQG2t5i5Ivg6JKOGyryfSeGhJ
	 wC6jUb4xLFRusAoI1cFDZziPBBLl9YjHGS0fhgRck3BQw6fC0Wng1hb1uNCkv6cMnG
	 sNxzVjkhppKpA==
Date: Wed, 19 Aug 2026 10:08:37 -1000
Message-ID: <5bbdc4cce52a27208853cec0bbba2903@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: luoliang@kylinos.cn
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Fix nonexistent field in sched-ext.rst
 example
In-Reply-To: <20260819031244.178638-3-luoliang@kylinos.cn>
References: <20260819031244.178638-1-luoliang@kylinos.cn>
 <20260819031244.178638-3-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
