Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2221FF38
	for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166617; cv=none; b=nA6HPzf0oh6Wu5J3+PTVMuTrGGz/K8mcdEwPI7BFStMXGroQKqJJDyjBY/Y//W6uTKnVe8OCfeaEqZKnf5W5CB+nZWeHdEiaxw79PV1j1Ld5M9M+KenIGCcMO4wzKPbhmHNX09K0F1iRYe4w9DS2UVvn1IvAZkBaa85sWHEevcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166617; c=relaxed/simple;
	bh=u0qm5d2UDeXUDpcCXEa/dr6tVH1BO/Km5npXzAvtfb4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=jk63EWKUgIDgtGBpO5ud9H2KGyQebW2OZlzcwkHlhOefIa4nl1Tib/c3KxACmdzoXtWWXJbUC3dXQF2/wZGPyGlqsCEZE8alScAFJ8XTHcxO4QlkBKOv9J+HcUNDUNnqE/RFoWV7OdzUPdhxsluX6xTbF9TMBZuLvHGYYMeCou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7ZKxkGK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7ZKxkGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428CFC19425;
	Tue, 10 Mar 2026 18:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773166617;
	bh=u0qm5d2UDeXUDpcCXEa/dr6tVH1BO/Km5npXzAvtfb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t7ZKxkGKNvXRnqpOPgIioia6ntEwX+kTcB94WIqmEPUogJUtC2K1GalZJS1/3jieW
	 eGp2xDbkewYG4T/O9l5diUAXHrRUQdcgqz0+19y0biwG0eJFg3NNdbW1FM+QVIYHbv
	 5QlCEcNBoJ6eAvEjFYXl9eAUCtxTk0wsEbPdYJRZHHq5nxIu++LqFMffNOK6A8IqDM
	 /+PXXi+7onKKJyUqfrIYS0f/H5w1l8vLQVYYQG1z/ED3eA+d/nPFR+PHuB/xzCHkkw
	 BtgvTebDIgCLxtUJqV5tyx733lhrQCegW+tgKIq/q2Jgb119Qy1iKDvQWzQULso9Tr
	 StTcUUJasr7hQ==
Date: Tue, 10 Mar 2026 08:16:56 -1000
Message-ID: <4f54f05e558a0b0efbe5bc22702bf79f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Jserv <jserv@ccns.ncku.edu.tw>
Subject: Re: [PATCH] sched_ext: Fix incomplete help text usage strings
In-Reply-To: <20260310173439.3032814-1-yphbchou0911@gmail.com>
References: <20260310173439.3032814-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Thanks for the patch. A couple of comments:

- scx_qmap is also missing -H in the usage line (it's already described in
  the help text below). Can you add that too while at it?

- runner.c: The v1 drops -h from the usage line. While this is consistent
  with the other sched_ext tools (none of them list -h in the usage line),
  can you please note this in the commit description?

Thanks.

--
tejun
