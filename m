Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9163CF1E7;
	Wed,  8 Jul 2026 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537782; cv=none; b=tvJCaUe1qSrTljoelOIfVp5MGCYad81xfszTnUT1aqzVy5r7H3GclBYJb0gcq4N8sjLpNvIzEP+7RyiNBaGB41hgB5FsFD0EpDNwJwKFRZLg31886N4PWPdSeNK5GREQqZ3Pp4If7GPafx7cMo9njLkxfo5vUwkhKAm59/f8j7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537782; c=relaxed/simple;
	bh=w6R1M/Rpcoaxjivwc1TyG4kcC2VjtdIBbUG/vAE1EQ8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=QlxblIXChDxhL8cEQSz+aOv+UQql/7P+4zZBG0jOfW2YrwOmMPKAGQST1At7LgZK9On1YpT23aul3XSpU04wI0EGzmoIE8edoVyntabo0WklmZ+dbq6Pg1U1t9WIk+VGtj0v1FA8XazLpQSQ3ABNfMyRxy93Y2bvgWedt7CRUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4kYAg81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4kYAg81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60A91F00A3E;
	Wed,  8 Jul 2026 19:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537779;
	bh=DFC7g9QMdiynP8lOtwszT3hstbYzJdMPLg8letF2gCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d4kYAg81vpm4MWZDTxLPTDDXqBu66bSma/I5QPT5HnByS4LQQDnVt2wne5B/pBVzy
	 1L3HvB4GeBIiIQ7VoC8H3YSzCe+yY+uqLENpGDNjVp/g8Xundilppnk+/q73ZTdSo9
	 D2IZxoNFIeRI7A2MGT2sgiAYkZHYIG+y6FtX6W/3bXZYtTqrUtVTr20KdO+3Ll7TDe
	 zf3W4eanKyklyP47s1syP9tSsyGP3/00FDwSoxJ/O71DW0euvfw73LJjtrg9Pv2cKQ
	 Leqq4uSdDDP9xtc55hsCDD/20239eX3IVGa2VgL3+FPn9O+PYhohG+Ny5rPL79//kJ
	 iljRZhX29YB3Q==
Date: Wed, 08 Jul 2026 09:09:39 -1000
Message-ID: <56d90cebab023f01f11c54cb16acfae9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 21/36] sched_ext: Maintain per-cpu effective cap copies for single-read checks
In-Reply-To: <20260707003820.B2BF11F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-22-tj@kernel.org> <20260707003820.B2BF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:38:20 +0000, sashiko-bot@kernel.org wrote:
> - [High] Unconditional dereference of global CID routing tables in `scx_process_sync_ecaps()` leads to NULL pointer dereference on error paths and out-of-bounds reads during layout updates.

The routing-table reads sit behind the llist_empty() guard, and the
teardown/discard path doesn't call scx_process_sync_ecaps(), so there's
no window where it runs against a torn-down or mid-update layout. Same as
the v2 round. No change.

Thanks.

-- 
tejun
