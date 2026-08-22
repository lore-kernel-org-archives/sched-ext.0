Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE9493643;
	Sat, 22 Aug 2026 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787383549; cv=none; b=uNPI2gOPlr9d7BCmxBd8zj5AVVmJXuVj7WhPCfXyf8vKzf3tqdkg0YY+HvT3R8r34i+AaBY4JTPY90kCRJ/r/giO17Dxg2KMnygOheZu7dCo9YkFBmlySuAS/gukN9WWLgzcvKIyCwv7PlXvNN6o+2CdzNrzmDNEjzeMsZC52ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787383549; c=relaxed/simple;
	bh=Ia8ev32IG2mI3RtuYyo04kjj7dextlL9bvNU5mS36iQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=PvK9C+GgS8+T7qGNaZPvyFhzGYuU1K8dn/V7mnrWqPnb5AGLs89Y853BMq59q96UYTsGHCQctP7+I14xJyp2nEJDqH2nsBD/9Grh/71cdym+oU9vIvH9aKUH7nAqDN5+aKpzUIKBQ03zCpSac5D6sfxGc+VcmAvBEk5GTa/Ju/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQklgMXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQklgMXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8081F000E9;
	Sat, 22 Aug 2026 07:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787383548;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QQklgMXvbM8FChfbtGGqMAbO5jJcqxetvR9LH7/2ZuUeUR6JI3SdLHRplam21CwXh
	 CgdoyiXbReUFQPAMVIZ+oVpCxcACDUkox5U2c6wzY2XSwzq40vM2wbfqPSLpzpBQBl
	 SPxcnAEtuX3FAnWqCs1AMVzMbUhEhp+lUafudWTmbwdAOvBsQkcM/w+yr/NXT9qvFC
	 vz6cvPuuwf4ljUzKhjuGbGf0P/l8y9hIFAwOxtt9Qg1kVapu20gGydcGSBsT78yYyM
	 vFlstfL67C6q36OIX5KNTxL2nyHb6udJjeTO+zOEU+n0pMwWWWpxgX73O3E9PgogN7
	 OjYN+wbbWDA2g==
Date: Fri, 21 Aug 2026 21:25:47 -1000
Message-ID: <97785680a7e3afb9e4ae3326639ac6f3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Gavin Guo <gavinguo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Sync tools headers from the scx repo
In-Reply-To: <20260818205711.3175265-1-tj@kernel.org>
References: <20260818205711.3175265-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

-- 
tejun
